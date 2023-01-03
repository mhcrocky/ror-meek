require 'resque/tasks'

task 'resque:setup' => :environment

namespace :podcast_episode_feed do
  desc 'Start a PodcastEpisodeFeederWorker for all Podcasts'

  task run: :environment do
    Podcast.pluck(:id).each do |podcast_id|
      Resque.enqueue(PodcastEpisodeFeederWorker, podcast_id)
    end
  end
end

namespace :article_post_feed do
  desc 'Start a ArticlePostFeederWorker for all Articles'

  task run: :environment do
    Article.pluck(:id).each do |article_id|
      Resque.enqueue(AritclePostFeederWorker, article_id)
    end
  end
end

namespace :email_notification_about_broken_podcast do
  desc 'Start a EmailNotificationAboutBrokenPodcastWorker'

  task run: :environment do
    Resque.enqueue(EmailNotificationAboutBrokenPodcastWorker)
  end
end

namespace :share_latest_episode do
  desc 'Will share latest episode from ShareQueue'
  task run: :environment do
    element = ShareQueue.without_publish_date.joins(:episode).ordered.first

    element.publish_episode! if element.present?
  end
end

namespace :email_notification_most_popular_episodes do
  desc 'Start a EmailNotificationMostPopularPodcastWorker for each user email'

  task run: :environment do
    return false unless Rails.env.production?

    customerio_notificator = CustomerioWeeklyEmailService.new

    User.where(weekly_emails_subscriptions: true).pluck(:email).each do |email|
      next if email.blank?

      customerio_notificator.notify(email)
    end
  end
end

namespace :scheduler do

  desc "Run job scheduler"
  task run_scheduler:  :environment do
    Rails.application.eager_load! # StackOverflow question #4300240

    scheduler = Rufus::Scheduler.new
    scheduler.stderr = File.open(File.join(Rails.root, "log", "cron.log"), 'a')

    shutdown_command = ->(_) { scheduler.shutdown(:wait) }

    trap("INT", shutdown_command)
    trap("TERM", shutdown_command)

    scheduler.every '6h' do
      Podcast.pluck(:id).each do |podcast_id|
        Resque.enqueue(PodcastEpisodeFeederWorker, podcast_id)
      end
    end

    scheduler.every '1d' do
      Resque.enqueue(EmailNotificationAboutBrokenPodcastWorker)
    end

    scheduler.every '6h' do
      Article.pluck(:id).each do |article_id|
        Resque.enqueue(ArticlePostFeederWorker, article_id)
      end
    end

    scheduler.cron "0 8,12,18,10,20,23,7,6,5,9,11,13,14,17 * * *" do 
      element = ShareQueue.without_publish_date.joins(:episode).ordered.first

      element.publish_episode! if element.present?
    end

    scheduler.cron "0 7 * * 6" do
      return false unless Rails.env.production?

      customerio_notificator = CustomerioWeeklyEmailService.new

      User.where(weekly_emails_subscriptions: true).pluck(:email).each do |email|
        next if email.blank?

        customerio_notificator.notify(email)
      end
    end

    scheduler.join
  end
end

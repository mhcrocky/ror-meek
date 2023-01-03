class EmailNotificationAboutBrokenPodcastWorker

  @queue = 'default'
  def self.perform
    broken_podcast_ids = Podcast.broken.pluck(:id)

    if broken_podcast_ids.present?
      PodcastMailer.broken_emails(broken_podcast_ids).deliver
    end
  end

end

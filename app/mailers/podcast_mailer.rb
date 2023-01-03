class PodcastMailer < ApplicationMailer
  default to: ENV.fetch('SUPPORT_EMAIL')

  def broken_emails(broken_podcast_ids)
    @podcasts = Podcast.find(broken_podcast_ids)

    mail(subject: 'Podcasts with broken RSS')
  end

end

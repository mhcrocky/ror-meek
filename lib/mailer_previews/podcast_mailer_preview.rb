class PodcastMailerPreview < ActionMailer::Preview
  # NOTE: To make this route work you should comment global interception in routes.rb
  # Because rails 4.1 does not allow use global interception with preview
  # This behavior is fixed in Rails 4.2.
  #
  # http://localhost:3000//rails/mailers/podcast_mailer/broken_emails
  def broken_emails
    broken_podcasts_ids = Podcast.limit(3).pluck(:id)

    PodcastMailer.broken_emails(broken_podcasts_ids)
  end

end

class NotifyMailer < ApplicationMailer

  def notify_recipient(recipient_email, media_name, media_path)
    @media_name = media_name
    @media_path = root_url + media_path

    subject = "Podcast: #{@media_name}"

    mail( to: recipient_email, subject: subject )
  end

end

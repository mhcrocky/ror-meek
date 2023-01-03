class FeedbackMailer < ApplicationMailer
  default to: ENV.fetch('SUPPORT_EMAIL')

  def feedback_email(feedback_id)
    @feedback = Feedback.find(feedback_id)

    mail(subject: 'New Feedback Received')
  end
end

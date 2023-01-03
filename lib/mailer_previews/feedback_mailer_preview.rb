class FeedbackMailerPreview < ActionMailer::Preview
  # NOTE: To make this route work you should comment global interception in routes.rb
  # Because rails 4.1 does not allow use global interception with preview
  # This behavior is fixed in Rails 4.2.
  #
  # http://localhost:3000//rails/mailers/feedback_mailer/feedback_email
  def feedback_email
    feedback_id = Feedback.last.id

    FeedbackMailer.feedback_email(feedback_id)
  end

end

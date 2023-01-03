class Api::FeedbacksController < Api::ApplicationController
  skip_before_action :verify_authenticity_token
  skip_before_action :ensure_json_request

  def create
    feedback = Feedback.new(feedback_params)

    if feedback.save
      FeedbackMailer.feedback_email(feedback.id).deliver
      render nothing: true
    else
      respond_with(feedback)
    end
  end

  private
  def feedback_params
    params.require(:feedback).permit(:name, :email, :body)
  end

end

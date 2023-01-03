class Api::UnsubscribesController < Api::ApplicationController

  def update
    user = User.where(email: update_email[:id]).first

    if user && user.weekly_emails_subscriptions
      user.update_attributes(weekly_emails_subscriptions: false)

      render json: { status: 200, message: 'Successfully unsubscribed' }
    else
      render json: { status: 422, message: 'Email not found' }
    end

  end

  private

  def update_email
    params.require(:unsubscribe).permit(:id)
  end

end

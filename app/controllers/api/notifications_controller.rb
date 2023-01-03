class Api::NotificationsController < Api::ApplicationController
  def create
    @notification = Notification.new(notify_params)

    if @notification.valid?
      NotifyMailer.notify_recipient(@notification.recipient_email, @notification.media_name, @notification.media_path).deliver
      render nothing: true
    else
      respond_with(@notification)
    end
  end

  private
  def notify_params
    params.require(:notify).permit( :recipient_email, :media_name, :media_path )
  end
end

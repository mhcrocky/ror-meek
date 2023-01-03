class Api::Devise::ConfirmationsController < Devise::ConfirmationsController

  # GET /resource/confirmation?confirmation_token=abcdef
  def show
    self.resource = resource_class.confirm_by_token(params[:confirmation_token])

    if resource.errors.empty?
      cookies[:error_message_meek] = 'Email address confirmed'

      unless signed_in?(resource_name)
        sign_in( self.resource )
      end
    else
      cookies[:error_message_meek] = resource.errors.full_messages.join(',')
    end

    redirect_to root_path
  end

end

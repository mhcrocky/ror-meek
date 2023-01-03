class Api::InvitationsController < Api::ApplicationController
  def create
    @invitation = Invitation.new(invite_params)
    @invitation.sender = current_user

    if @invitation.save
      user_name = current_user.full_name || current_user.email
      InviteMailer.invite_message(current_user.email, user_name, @invitation.id).deliver

      render nothing: true
    else
      respond_with(@invitation)
    end
  end

  def edit
    # Check if token is valid.
    invitation = Invitation.find_by(token: params[:invitation_token] )

    if invitation && User.find_by(email: invitation.recipient_email).nil?
      render nothing: true, status: 200
    else
      render nothing: true, status: 422
    end
  end

  def update
    invitation = Invitation.find_by(token: params[:invite][:invitation_token] )
    if invitation && User.find_by(email: invitation.recipient_email).nil?

      @user = User.new(accept_invitation_params)
      @user.email = invitation.recipient_email
      @user.invitation = invitation
      @user.confirmed_at = DateTime.now

      if @user.save
        invitation.update_attribute(:token, nil)
        sign_in(@user)
        render nothing: true, status: 200
      else
        cookies[:error_message_meek] = @user.errors.full_messages.to_sentence+' Please try again.'
        render status: 200, json: {error: 'wrong data'}
      end

    else
      render nothing: true, status: 422
    end
  end

  private
  def invite_params
    params.require(:invite).permit( :recipient_email, :subject, :message, :friend_name )
  end

  def accept_invitation_params
    params.require(:invite).permit( :password, :password_confirmation, :first_name, :last_name )
  end
end

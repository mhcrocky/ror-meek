class InviteMailer < ApplicationMailer
  def invite_message(from, from_name, invitation_id)
    invitation = Invitation.find(invitation_id)

    @from_name       = from_name
    @friend_name     = invitation.friend_name
    @message         = invitation.message
    @invitation_link = accept_invitation_url(invitation.token)

    mail_from = from.presence || 'no-reply@meek.co'
    mail( from: mail_from, to: invitation.recipient_email, subject: invitation.subject )
  end

  private
  def accept_invitation_url(token)
    root_url + 'invitees/' + token
  end
end

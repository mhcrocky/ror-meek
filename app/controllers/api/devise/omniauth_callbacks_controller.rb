class Api::Devise::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    generic_callback('facebook')
  end

  def twitter
    generic_callback('twitter')
  end

  def failure
    cookies[:error_message_meek] = 'Something went wrong'
    redirect_to root_url
  end

  private
  def generic_callback(provider)
    identity = Identity.find_for_oauth( env['omniauth.auth'] )

    @user = identity.user

    dummy_password = Devise.friendly_token[0,20]

    if @user.nil?
      @user = User.find_by( email: identity.email ) if identity.email

      if @user.nil?
        @user = User.new({
          email: identity.email || '',
          first_name: identity.name.split(' ')[0].to_s.strip,
          last_name: identity.name.split(' ')[-1].to_s.strip,
          password: dummy_password,
          password_confirmation: dummy_password
        })
      end

      @user.confirm
      @user.save

      identity.update_attributes( user_id: @user.id )
    end

    sign_in_and_redirect( @user, event: :authentication )
  end

  def after_sign_in_path_for(resource)
    cookies[:previouseState] || root_path
  end

end

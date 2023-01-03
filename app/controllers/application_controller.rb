class ApplicationController < ActionController::Base
  include ApplicationHelper

  # https://github.com/plataformatec/devise/tree/3-stable#strong-parameters
  before_action :configure_permitted_parameters, if: :devise_controller?

  respond_to :html, :json

  protect_from_forgery with: :exception

  def index
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:first_name, :last_name,
                                                          :email, :password, 
                                                          :password_confirmation) }
  end
end

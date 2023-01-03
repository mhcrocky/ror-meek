class Api::ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session

  # TODO: Use gem "Responders"
  respond_to :json

  before_action :ensure_json_request

  private
  def ensure_json_request
    # All requests are JSON
    # 406 - Not Acceptable
    return if request.format == :json
    render nothing: true, status: 406
  end
end

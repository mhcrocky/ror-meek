class Api::UserController < Api::ApplicationController
  before_action :authenticate_user!
end

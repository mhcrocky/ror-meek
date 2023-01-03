class Api::BackgroundsController < Api::ApplicationController

  def show
    @background = Background.find_by(location: Background.locations[params[:id].to_sym])
  end

end

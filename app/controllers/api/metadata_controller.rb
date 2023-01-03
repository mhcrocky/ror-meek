class Api::MetadataController < ApplicationController

  respond_to :json

  def show
    @meta_data = RadioStation.friendly.find(params[:radio_station_id]).stream_metadata

    respond_with @meta_data
  end

end

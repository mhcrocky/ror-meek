class Api::CountriesController < ApplicationController

  respond_to :json

  def index
    @countries = Country.all
  end

  def show
    @country = Country.includes(:regions).find(params[:id])
  end

end

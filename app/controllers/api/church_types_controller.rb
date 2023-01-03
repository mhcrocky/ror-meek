class Api::ChurchTypesController < Api::ApplicationController
  def index
    @church_types = ChurchType.ordered
  end
end

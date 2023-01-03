class Api::CategoriesController < Api::ApplicationController
  def index
    @categories = Category.ordered
  end

  def show
    @category = Category.friendly.find(params[:id])
  end
end

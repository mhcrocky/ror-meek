class Api::ArticlesController < Api::ApplicationController
  def index
    @articles = Article.ordered
  end

  def show
    @article = Article.friendly.find(params[:id])
  end
end

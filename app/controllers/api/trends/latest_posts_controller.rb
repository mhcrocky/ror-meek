class Api::Trends::LatestPostsController < Api::ApplicationController
  def index
    @posts = Article.ordered.limit(4).includes(:article, :category)
  end
end

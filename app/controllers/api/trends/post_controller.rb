class Api::Trends::PostsController < Api::ApplicationController
  def index
    @posts = Post.includes(:article, :category).where(id: top_articles)
  end
end

class Api::PostsController < Api::ApplicationController
  def index
    @posts = article.posts.with_search(params[:search_query]).order(release_date: :desc).page(params[:page]).per(PER)
  end

  def show
    @post = article.posts.friendly.find(params[:id])
  end

  private

  def article
    @article ||= Article.friendly.find(params[:article_id])
  end
end

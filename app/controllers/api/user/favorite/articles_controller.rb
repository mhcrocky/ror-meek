class Api::User::Favorite::ArticlesController < Api::UserController
  def index
    @favorite_articles = current_user.favorite_articles.includes(posts: :category)
  end
end

class Api::User::Favorite::PodcastsController < Api::UserController

  def index
    @favorite_podcasts = current_user.favorite_podcasts.includes(episodes: :category)
  end

end

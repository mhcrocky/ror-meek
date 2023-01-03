class Api::User::Favorite::EpisodesController < Api::UserController

  def index
    @favorite_episodes = current_user.favorite_episodes.includes(:podcast, :category)
  end

end

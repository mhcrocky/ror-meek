class Api::User::Recent::EpisodesController < Api::UserController

  def index
    @recent_plays_episodes = Play.includes(media: :category)
                                 .episodes_only
                                 .for_user(current_user.id)
                                 .order(updated_at: :desc)
  end

end

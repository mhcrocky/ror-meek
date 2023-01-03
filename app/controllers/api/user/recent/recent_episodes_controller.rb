class Api::User::Recent::RecentEpisodesController < Api::UserController
  def index
    @episodes = Episode
      .select('distinct on (podcast_id) podcast_id, *')
      .where(podcast_id: current_user.favorite_podcasts.pluck(:id))
      .order('podcast_id, release_date DESC, created_at DESC')    
  end
end

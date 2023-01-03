class Api::Trends::EpisodesController < Api::ApplicationController
  def index
    top_episodes = Play.last_ten_days.episodes_only.get_top(8)
    @episodes = Episode.includes(:podcast, :category).where(id: top_episodes)
  end
end

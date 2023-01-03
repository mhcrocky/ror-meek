class Api::Trends::LatestEpisodesController < Api::ApplicationController
  def index
    @episodes = Episode.ordered.limit(4).includes(:podcast, :category)
  end
end

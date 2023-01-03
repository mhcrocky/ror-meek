class Api::PodcastsController < Api::ApplicationController

  def index
    @podcasts = Podcast.ordered
  end

  def show
    @podcast = Podcast.friendly.find(params[:id])
  end

end

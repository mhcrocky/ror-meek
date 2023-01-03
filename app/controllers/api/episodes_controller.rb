class Api::EpisodesController < Api::ApplicationController

  def index
    find_podcast
    @episodes = @podcast.episodes.with_search(params[:search_query]).ordered.page(params[:page]).per(PER)
  end

  def show
    find_podcast
    @episode = @podcast.episodes.friendly.find(params[:id])
  end

  private
  def find_podcast
    @podcast ||= Podcast.friendly.find(params[:podcast_id])
  end

end

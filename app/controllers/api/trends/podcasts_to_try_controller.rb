class Api::Trends::PodcastsToTryController < Api::ApplicationController
  def index
    @podcasts_to_try = Podcast.order('random()').limit(4)
  end
end

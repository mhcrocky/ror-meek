require 'net/http'
require 'uri'

class PrerendererRecacheService
  # NOTE: prerenderer Recache particular page
  # Docs: https://prerender.io/documentation/recache
  # This feature is avalible only in production mode, because prerenderer service only works in production.

  def initialize(episode_id)
    episode = Episode.includes(podcast: :category).find(episode_id)

    _slug_episode  = episode.slug
    _slug_podcast  = episode.podcast.slug
    _slug_category = episode.podcast.category.slug

    @token = ENV.fetch('PRERENDER_TOKEN')
    @url = 'http://localhost:3000/' + _slug_category + '/' + _slug_podcast + '/' + _slug_episode
  end

  def recache
    unless Rails.env.production?
      Rails.logger.info('Prerenderer Recache stopped. It works only in production mode.')
      return false
    end

    uri = URI.parse('http://api.prerender.io/recache')

    request = Net::HTTP::Post.new(uri)
    request.content_type = 'application/json'
    request.body = JSON.dump({
      'prerenderToken' => @token,
      'url' => @url
    })

    Net::HTTP.start(uri.hostname, uri.port) do |http|
      http.request(request)
    end
  end
end

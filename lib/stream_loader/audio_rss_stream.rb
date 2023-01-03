require 'rss'

class StreamLoader::AudioRssStream

  def initialize(url)
    @stream_url = url
    return nil if @stream_url.blank?

    @audio_rss = fetch_rss(@stream_url)
  end

  def get_feed_episodes
    feed_episodes = []

    @audio_rss.items.each do |item|
      next unless item.enclosure && item.enclosure.url

      feed_episodes.push({
        video:              false,
        name:               item.title,
        release_date:       item.pubDate.to_date,
        duration:           duration(item),
        stream_url:         item.enclosure.url,
        short_description:  short_description(item) || ''
      })
    end

    feed_episodes
  end

  def is_valid?
    return false if @stream_url.blank?
    return false if @audio_rss.nil?

    begin
      HTTParty.get(@stream_url)
      true
    rescue Exception => error
      false
    end
  end

  private

  def fetch_rss(feed_url)
    begin
      _response = HTTParty.get(feed_url)
      RSS::Parser.parse(_response.body, false)
    rescue Exception => error
      nil
    end
  end

  def duration(item)
    itunes_duration_hash = item.itunes_duration
    return nil unless itunes_duration_hash

    duration = 0
    duration += itunes_duration_hash.hour.to_i.hours
    duration += itunes_duration_hash.minute.to_i.minutes
    duration += itunes_duration_hash.second.to_i

    return duration
  end

  def short_description(item)
    item.itunes_subtitle.presence || item.itunes_summary
  end
end

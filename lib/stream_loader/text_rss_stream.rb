require 'rss'

class StreamLoader::TextRssStream
  def initialize(url)
    @stream_url = url
    return nil if @stream_url.blank?

    @text_rss = fetch_rss(@stream_url)
  end

  def get_feed_posts
    feed_posts = []

    @text_rss.items.each do |item|
      feed_posts.push({
        name:               item.title,
        body:               item.content_encoded,
        release_date:       item.pubDate.to_date,
        short_description:  item.description || '',
        stream_url:         item.link
      })
    end
    feed_posts
  end

  def is_valid?
    return false if @stream_url.blank?
    return false if @text_rss.nil?

    begin
      HTTParty.get(@stream_url, verify: false)
      true
    rescue Exception => error
      false
    end
  end

  private

  def fetch_rss(feed_url)
    begin
      _response = HTTParty.get(feed_url, verify: false)
      RSS::Parser.parse(_response.body, false)
    rescue Exception => error
      nil
    end
  end

  def short_description(item)
    item.itunes_subtitle.presence || item.itunes_summary
  end
end

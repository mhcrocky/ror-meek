class StreamLoader::YoutubeStream

  def initialize(url)
    @stream_url = url
    return nil if @stream_url.blank?

    channel_id = Yt::URL.new(@stream_url).id

    @channel = Yt::Channel.new(id: channel_id)
  end

  def get_feed_episodes
    @channel.videos.map do |video|
      {
        video:              true,
        name:               video.title,
        release_date:       video.published_at.to_date,
        duration:           video.duration,
        stream_url:         'https://www.youtube.com/embed/' + video.id,
        short_description:  video_description(video)
      }
    end
  end

  def is_valid?
    return false if @stream_url.blank?
    @channel.is_linked
  rescue Yt::NoItemsError
    false
  end

  private

  def video_description(video)
    if video.try(:description).present?
      video.description
    else
      ''
    end
  end
end

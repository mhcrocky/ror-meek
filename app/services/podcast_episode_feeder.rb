class PodcastEpisodeFeeder

  def self.import!(podcast_id)
    _podcast = Podcast.find_by(id: podcast_id)
    return false if _podcast.nil?

    new(_podcast)
    PublisherQueueService.add_new_episodes_to_publish_queue(_podcast)
    PublisherQueueService.add_old_episodes_to_publish_queue(_podcast)

    true
  end

  def initialize(podcast)
    @podcast = podcast
    @podcast_episodes = podcast.episodes

    @audio_rss_stream        = StreamLoader::AudioRssStream.new( @podcast.feed_url )
    @audio_rss_second_stream = StreamLoader::AudioRssStream.new( @podcast.secondary_feed_url )
    @vimeo_stream            = StreamLoader::VimeoStream.new( @podcast.video_vimeo_feed )
    @youtube_stream          = StreamLoader::YoutubeStream.new( @podcast.video_youtube_feed )
    @video_rss_stream        = StreamLoader::VideoRssStream.new( @podcast.video_rss_feed )

    self.start_import
  end

  def start_import
    full_feed = []

    full_feed += @audio_rss_stream.get_feed_episodes        if @audio_rss_stream.is_valid?
    full_feed += @audio_rss_second_stream.get_feed_episodes if @audio_rss_second_stream.is_valid?
    full_feed += @vimeo_stream.get_feed_episodes            if @vimeo_stream.is_valid?
    full_feed += @youtube_stream.get_feed_episodes          if @youtube_stream.is_valid?
    full_feed += @video_rss_stream.get_feed_episodes        if @video_rss_stream.is_valid?

    ActiveRecord::Base.no_touching do
      if full_feed.any?
        set_podcast_as_broken(false)
        create_episodes_from( full_feed )
      else
        set_podcast_as_broken(true)
      end
    end

    create_transcriptions if @podcast.create_transcription
  end

  def create_transcriptions
    scope = @podcast.episodes
    scope = scope.only_new_episodes if @podcast.transcript_only_new
    scope.each do |episode|
      Resque.enqueue(SpeechToTextWorker, episode.id) if episode.transcription.blank?
    end
  end

  private

  def create_episodes_from(feed_episodes)
    feed_episodes.each do |episode_attributes|

      episode = @podcast_episodes.to_a.find {|ep| ep[:stream_url] == episode_attributes[:stream_url]} || Episode.new
      episode.assign_attributes(with_default_attributes(episode_attributes.compact))

      if episode.changed.any? && episode.valid?
        episode.save
      end
    end
  end

  def with_default_attributes(item)
    item.merge({
      podcast_id: @podcast.id,
      noindex: @podcast.noindex
    })
  end

  def set_podcast_as_broken(bool)
    @podcast.update_attributes(feed_is_broken: bool) if @podcast.feed_is_broken != bool
  end
end

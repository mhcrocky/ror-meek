class PublisherService

  def self.call(episode)
    @episode  = episode
    @podcast  = episode.podcast
    @category = episode.podcast.category

    FacebookPageApi.new.publish(full_message, share_post_options)
  end



  def self.full_message
    default_message = @episode.video? ? video_message : audio_message
    category_hash_tag = to_hash_tag(@category.name)

    "#{default_message} #meek ##{category_hash_tag}"
  end

  def self.meta_name
    @podcast.name + ' - ' + @episode.name
  end

  def self.meta_description
    @podcast.meta_description
  end

  def self.share_post_options
    {
      'name': meta_name,
      'link': link_to_episode,
      'caption': app_root_url,
      'description': meta_description,
      'picture': get_preview_picture
    }
  end



  def self.get_preview_picture
    if @episode.video? && (@episode.stream_url_type == 'video/youtube')
      youtube_code = @episode.stream_url.split('/')[-1]
      return "http://img.youtube.com/vi/#{ youtube_code }/0.jpg"
    end

    'https://' + app_root_url + @podcast.normal_path
  end

  def self.to_hash_tag(str)
    str.downcase.tr(' ', '_').tr('\'', '')
  end

  def self.link_to_episode
    'https://' + app_root_url + '/' + @category.slug + '/' + @podcast.slug + '/' + @episode.slug
  end

  def self.video_message
    [
      "For Video:",
      "Watch now!",
      "Play now.",
      "Watch the video.",
      "Play the video.",
      "A great new video.",
      "Watch the episode.",
      "A new episode is here.",
      "Watch the latest podcast."
    ].sample
  end

  def self.audio_message
    [
      "Listen now.",
      "Listen to the latest podcast.",
      "Come listen to the latest podcast.",
      "New insights.",
      "A new Christian podcast.",
      "Listen online now.",
      "A great new podcast.",
      "Worth listening to."
    ].sample
  end

  def self.app_root_url
    if Rails.env.production?
      'www.meek.co'
    else
      'staging.meek.co'
    end
  end
end

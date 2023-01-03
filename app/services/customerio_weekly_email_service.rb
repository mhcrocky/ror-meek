class CustomerioWeeklyEmailService

  def initialize
    @date_today = Date.today.strftime('%d %b %Y')
    @ep_1, @ep_2 = get_most_popular_episodes
  end

  def notify(email)
    $customerio.anonymous_track('weekly_update_campaing',
      recipient: email,
      unsubscribe: unsubscribe_link_for(email),
      date_today: @date_today,
      episode_1: [
        @ep_1[:episode_type_title],
        @ep_1[:episode_title],
        @ep_1[:episode_url],
        @ep_1[:episode_image_url]
      ],
      episode_2: [
        @ep_2[:episode_type_title],
        @ep_2[:episode_title],
        @ep_2[:episode_url],
        @ep_2[:episode_image_url]
      ]
    )
  end

  # Most two most popular episodes
  # If there are no most popular episodes - get random episode
  def get_most_popular_episodes
    last_episode_ids = Episode.last(2).map(&:id)
    top_episode_ids = Play.last_ten_days.episodes_only.joins( 'INNER JOIN episodes ON plays.media_id = episodes.id' ).get_top(2)

    top_episode_ids.push(last_episode_ids[0]) if top_episode_ids.size != 2
    top_episode_ids.push(last_episode_ids[1]) if top_episode_ids.size != 2

    episodes = Episode.includes(:podcast, :category).where(id: top_episode_ids)

    episodes.map do |episode|
      {
        episode_type_title: episode.video? ? 'Watch Now' : 'Listen Now',
        episode_title:      episode.name,
        episode_url:        Rails.application.config.action_mailer.asset_host + "/#{episode.podcast.category.slug}/#{episode.podcast.slug}/#{episode.slug}",
        episode_image_url:  Rails.application.config.action_mailer.asset_host + episode.podcast.normal_path
      }
    end
  end

  private
  def unsubscribe_link_for(email)
    Rails.application.config.action_mailer.asset_host + '/unsubscribe?email=' + email
  end
end

json.array! @recent_plays_episodes do |play|
  episode = play.media
  next if episode.nil?

  json.partial!('api/episodes/episode', episode: episode)

  json.podcast do
    json.(episode.podcast, *episode.podcast.attributes.keys)
    json.image episode.podcast.normal_path
  end

  json.for_preview do
    json.category_name   episode.podcast.category.name
    json.category_path   episode.podcast.category.slug
    json.name            episode.name
    json.description     episode.podcast.short_description
    json.image           episode.podcast.normal_path
    json.path            "/#{episode.category.slug}/#{episode.podcast.slug}/#{episode.slug}"
    json.duration        episode.duration
    json.stopped_at      play.stopped_at
  end
end

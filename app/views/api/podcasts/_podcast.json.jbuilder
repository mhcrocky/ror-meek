require 'htmlentities'


json.(podcast, *podcast.attributes.keys)
json.image     podcast.normal_path
json.googlebot podcast.image(:googlebot)
json.wallpaper podcast.wallpaper_path
json.path      "/#{podcast.category.slug}/#{podcast.slug}"
json.private   podcast.private

json.current_episode do
  json.partial!('api/episodes/episode', episode: podcast.episodes.ordered.first) if podcast.episodes.ordered.first
end

json.for_preview do
  json.category_name   podcast.category.name
  json.category_path   podcast.category.slug
  json.name            podcast.name
  json.description     HTMLEntities.new.decode podcast.short_description
  json.image           podcast.normal_path
  json.path            "/#{podcast.category.slug}/#{podcast.slug}"
  json.duration        nil
  json.stopped_at      nil
  json.private         podcast.private 
end

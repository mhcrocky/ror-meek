require 'htmlentities'

json.(episode, *episode.attributes.keys)

json.stream_url_type    episode.stream_url_type
json.meta_description   episode.podcast&.meta_description
json.image              episode.podcast&.normal_path
json.googlebot          episode.podcast&.image(:googlebot)
json.video              episode.video
json.short_description  HTMLEntities.new.decode episode.short_description
json.noindex            episode.noindex
json.released_at        episode.released_at
json.path               "/#{episode.podcast&.category&.slug}/#{episode.podcast&.slug}/#{episode.slug}"
json.private            episode.podcast.private?

json.array! @favorite_podcasts do |podcast|
  json.partial!('api/podcasts/podcast', podcast: podcast)

  json.for_preview do
    json.category_name   podcast.category.name
    json.category_path   podcast.category.slug
    json.name            podcast.name
    json.description     podcast.short_description
    json.image           podcast.normal_path
    json.path            "/#{podcast.category.slug}/#{podcast.slug}"
    json.duration        nil
    json.stopped_at      nil
  end
end

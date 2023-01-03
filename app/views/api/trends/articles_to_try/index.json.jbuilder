json.array! @articles_to_try do |podcast_to_try|
  json.partial!('api/podcasts/podcast', podcast: podcast_to_try)
end

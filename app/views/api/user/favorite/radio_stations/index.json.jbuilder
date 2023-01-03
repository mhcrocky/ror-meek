json.array! @favorite_stations do |station|
  json.partial!('api/radio_stations/radio_station', radio_station: station)

  json.for_preview do
    json.category_name   station.category.name
    json.category_path   "/radio/#{station.category.slug}"
    json.name            station.name
    json.description     station.short_description
    json.image           station.normal_path
    json.path            "/radio/#{station.category.slug}/#{station.slug}"
    json.duration        nil
    json.stopped_at      nil
  end
end

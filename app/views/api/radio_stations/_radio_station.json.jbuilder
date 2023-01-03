json.cache! radio_station do
  json.(radio_station, *radio_station.attributes.keys)
  json.image     radio_station.normal_path
  json.googlebot radio_station.image(:googlebot)
  json.wallpaper radio_station.wallpaper_path
  json.path      "/radio/#{radio_station.category.slug}/#{radio_station.slug}"

  json.for_preview do
    json.category_name   radio_station.category.name
    json.category_path   "/radio/#{radio_station.category.slug}"
    json.name            radio_station.name
    json.description     radio_station.short_description
    json.image           radio_station.normal_path
    json.path            "/radio/#{radio_station.category.slug}/#{radio_station.slug}"
    json.duration        nil
    json.stopped_at      nil
  end
end

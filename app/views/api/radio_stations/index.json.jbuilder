json.cache! @radio_stations.maximum(:updated_at) do
  json.array! @radio_stations, partial: 'radio_station', as: :radio_station
end
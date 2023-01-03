json.array! @radio_stations do |radio_station|
  json.partial!('api/radio_stations/radio_station', radio_station: radio_station)
end

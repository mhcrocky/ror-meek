json.partial! 'radio_station', radio_station: @radio_station

json.category do
  json.name @radio_station.category.name
  json.path "/radio/#{@radio_station.category.slug}"
end

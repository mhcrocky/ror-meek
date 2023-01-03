json.data do
  json.array! @paginated_results do |radio_station|
    json.partial!('api/radio_stations/radio_station', radio_station: radio_station)
  end
end

json.next_page @paginated_results.next_page

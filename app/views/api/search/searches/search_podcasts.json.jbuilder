json.data do
  json.array! @paginated_results do |podcast|
    json.partial!('api/podcasts/podcast', podcast: podcast)
  end
end

json.next_page @paginated_results.next_page

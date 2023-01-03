json.data do
  json.array! @episodes, partial: 'episode', as: :episode
end

json.pagination do
  json.next  @episodes.next_page
  json.total @episodes.total_count
end

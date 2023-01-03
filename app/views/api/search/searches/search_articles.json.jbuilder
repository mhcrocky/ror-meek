json.data do
  json.array! @paginated_results do |article|
    json.partial!('api/articles/article', article: article)
  end
end

json.next_page @paginated_results.next_page

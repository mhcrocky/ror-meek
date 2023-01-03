json.data do
  json.array! @posts, partial: 'post', as: :post
end
  
json.pagination do
  json.next  @posts.next_page
  json.total @posts.total_count
end

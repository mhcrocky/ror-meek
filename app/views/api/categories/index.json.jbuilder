json.cache! @categories.maximum(:updated_at) do
  json.array! @categories, partial: 'category', as: :category
end

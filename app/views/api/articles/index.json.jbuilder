json.cache! @articles.maximum(:updated_at) do
  json.array! @articles, partial: 'article', as: :article
end

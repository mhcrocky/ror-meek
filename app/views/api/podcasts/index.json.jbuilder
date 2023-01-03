json.cache! @podcasts.maximum(:updated_at) do
  json.array! @podcasts, partial: 'podcast', as: :podcast
end
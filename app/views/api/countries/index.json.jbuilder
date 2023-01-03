json.cache! @countries.maximum(:updated_at) do
  json.array! @countries, partial: 'country', as: :country
end
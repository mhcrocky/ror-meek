json.cache! @country do
  json.partial! 'country', country: @country
  json.regions @country.regions, partial: 'region', as: :region
end
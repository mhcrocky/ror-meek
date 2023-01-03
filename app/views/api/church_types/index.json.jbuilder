json.cache! @church_types.maximum(:updated_at) do
  json.array! @church_types, partial: 'church_type', as: :church_type
end
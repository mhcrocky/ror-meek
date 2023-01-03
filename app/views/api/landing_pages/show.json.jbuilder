json.cache!(@landing_page.updated_at) do
  json.name       @landing_page.name
  json.title      @landing_page.title
  json.content    @landing_page.content
  json.updated_at @landing_page.updated_at.to_s(:meek_date)
end

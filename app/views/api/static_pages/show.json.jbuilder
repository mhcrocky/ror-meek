json.cache!(@static_page.updated_at) do
  json.name       @static_page.name
  json.title      @static_page.title
  json.content    @static_page.content
  json.updated_at @static_page.updated_at.to_s(:meek_date)
end

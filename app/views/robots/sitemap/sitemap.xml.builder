xml.instruct!
xml.urlset 'xmlns' => 'http://www.sitemaps.org/schemas/sitemap/0.9' do
  xml.url do
    xml.loc(root_url)
    xml.changefreq('daily')
    xml.priority(1)
  end

  site_map_datas.each do |site_map_data|
    xml.url do
      xml.loc(site_map_data[:url])
      xml.lastmod(site_map_data[:date])
      xml.changefreq('daily')
      xml.priority(1)
    end
  end
end


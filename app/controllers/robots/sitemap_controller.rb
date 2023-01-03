class Robots::SitemapController < ApplicationController
  layout false

  def sitemap
    render 'sitemap', formats: :xml
  end

  helper_method def site_map_datas
    SiteMapCreator.call(root_url)
  end
end

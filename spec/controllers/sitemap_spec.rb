require 'rails_helper'

RSpec.describe Robots::SitemapController do
  describe "sitemap.xml" do
    it 'sitemap should be generated' do
      get :sitemap
      expect(response.status).to eq(200)
    end
  end
end

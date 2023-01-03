require 'rails_helper'

describe ArticlePostFeeder do
  let(:meek_rss) { Rails.root.join('spec', 'support', 'rss', 'meek_rss.xml').to_s }
  let(:meek_rss_without_old_posts) { Rails.root.join('spec', 'support', 'rss', 'meek_rss_without_old_posts.xml').to_s }

  before do
    meek_rss_dbl = double('Meek RSS', body: File.open(meek_rss, 'rb').read)
    meek_rss_without_old_posts_dbl = double('Meeek RSS without old posts', body: File.open(meek_rss_without_old_posts, 'rb').read)
   
    allow(HTTParty).to receive(:get).with(meek_rss, verify: false).and_return(meek_rss_dbl)
    allow(HTTParty).to receive(:get).with(meek_rss_without_old_posts, verify: false).and_return(meek_rss_without_old_posts_dbl)
  end

  let(:article_category) { create :category, kind: 2 }

  describe 'upload feed' do
    let(:article) { create :article, category_id: article_category.id, feed_url: meek_rss }
        
    it 'it keeps the old records' do
      described_class.import!(article.id)
      expect(article.posts.where(name: 'Old post')).to exist
      article.update_attributes(feed_url: meek_rss_without_old_posts)
      described_class.import!(article.id)
      expect(article.posts.where(name: 'Old post')).to exist
      expect(article.posts.where(name: 'New post')).to exist
    end
  end
end

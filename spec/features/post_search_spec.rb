require 'rails_helper'

feature 'Search page', js: true, type: :feature do
  let(:home_page) { HomePage.new }
  let(:search_page) { SearchPage.new }
 
  let(:article_category) { create :category, kind: 2 }

  let!(:article1) { create :article, category_id: article_category.id, name: 'First article', tags: 'article eTag' }
  let!(:post1)     { create :post, article_id: article1.id, name: 'First post', tags: 'post aTag' }
  let!(:post2)     { create :post, article_id: article1.id, name: 'Second post', tags: 'post bTag' }

  before do
    home_page.load
  end

  it 'should be able to find post by name' do
    home_page.main_header.search_input.set 'First post'
    home_page.main_header.search_submit.click
    expect(search_page).to have_text('First post')
    expect(search_page).to have_no_text('Second post')
  end

  it 'should be able to find post by tags' do
    home_page.main_header.search_input.set 'bTag'
    home_page.main_header.search_submit.click
    expect(search_page).to have_text('Second post')
    expect(search_page).to have_no_text('First post')
  end
end

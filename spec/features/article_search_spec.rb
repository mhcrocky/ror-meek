require 'rails_helper'

feature 'Search page', js: true, type: :feature do
  let(:home_page) { HomePage.new }
  let(:search_page) { SearchPage.new }
 
  let(:article_category) { create :category, kind: 2 }

  let!(:article1) { create :article, category_id: article_category.id, name: 'First article', tags: 'article aTag' }
  let!(:article2) { create :article, category_id: article_category.id, name: 'Second article', tags: 'article bTag' }
  

  before do
    home_page.load
  end

  it 'should be able to find article by name' do
    home_page.main_header.search_input.set 'First article'
    home_page.main_header.search_submit.click
    expect(search_page).to have_text('First article')
    expect(search_page).to have_no_text('Second article')
  end

  it 'should be able to find article by tags' do
    home_page.main_header.search_input.set 'bTag'
    home_page.main_header.search_submit.click
    expect(search_page).to have_text('Second article')
    expect(search_page).to have_no_text('First article')
  end
end

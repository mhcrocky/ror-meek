require 'rails_helper'

feature 'Podcast index page', js: true, type: :feature do
  let(:podcast_index_page) { PodcastIndexPage.new }

  let(:podcast_category) { create :category, kind: 1 }
  let!(:podcast) { create :podcast, category_id: podcast_category.id }

  before do
    podcast_index_page.load(slug: podcast_category.slug)
  end

  it 'should be loaded properly' do
    sleep 1
    expect(podcast_index_page).to be_displayed
  end

  it_should_behave_like 'grid list tabs' do
    let!(:visible_page) { podcast_index_page }
  end
end

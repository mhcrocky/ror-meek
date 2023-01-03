require 'rails_helper'

feature 'Search page', js: true, type: :feature do
  let(:home_page) { HomePage.new }
  let(:search_page) { SearchPage.new }
  let(:podcast_category) { create :category, kind: 1 }
  let!(:podcast1) { create :podcast, category_id: podcast_category.id, name: 'First podcast', tags: 'aTag bTag' }
  let!(:podcast2) { create :podcast, category_id: podcast_category.id, name: 'Second podcast', tags: 'cTag dTag' }

  let!(:episode1) { create :episode, podcast: podcast1, name: 'First episode', transcription: 'First transcription' }
  let!(:episode2) { create :episode, podcast: podcast1, name: 'Second episode', transcription: 'Second transcription' }

  before do
    home_page.load

    home_page.main_header.search_input.set 'First podcast'
  end

  it 'should have search' do
    expect(search_page.main_header.search_input).to be_visible
  end

  it 'should be able to find item' do
    home_page.main_header.search_input.set 'First podcast'
    home_page.main_header.search_submit.click
    expect(search_page).to have_text('First podcast')
    expect(search_page).to have_no_text('Second podcast')

    search_page.main_header.search_input.set 'Second podcast'
    home_page.main_header.search_submit.click
    expect(search_page).to have_text('Second podcast')
    expect(search_page).to have_no_text('First podcast')

    search_page.main_header.search_input.set 'podcast'
    home_page.main_header.search_submit.click
    expect(search_page).to have_text('First podcast')
    expect(search_page).to have_text('Second podcast')
  end

  it 'should be able to find in transcription' do
    home_page.main_header.search_input.set 'First transcription'
    home_page.main_header.search_submit.click
    expect(search_page).to have_text('First transcription')
    expect(search_page).to have_no_text('Second transcription')

    home_page.main_header.search_input.set 'Second transcription'
    home_page.main_header.search_submit.click
    expect(search_page).to have_text('Second transcription')
    expect(search_page).to have_no_text('First transcription')
  end

  it 'should be able to find item by tags' do
    home_page.main_header.search_input.set 'aTag'
    home_page.main_header.search_submit.click
    expect(search_page).to have_text('First podcast')
    expect(search_page).to have_no_text('Second podcast')
    expect(search_page).to have_no_text('First transcription')
    expect(search_page).to have_no_text('Second transcription')
  end
end

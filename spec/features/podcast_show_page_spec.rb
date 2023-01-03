require 'rails_helper'

feature 'Podcast Show Page', js: true, type: :feature do
  let(:podcast_category) { create :category, kind: 1 }
  let!(:podcast) { create :podcast, category_id: podcast_category.id }
  let(:podcast_page) { PodcastPage.new }

  before do
    10.times do
      FactoryBot.create(:episode, podcast_id: podcast.id)
    end
    podcast_page.load(category_slug: podcast_category.slug, slug: podcast.slug)
  end

  it 'was loaded properly' do
    expect(podcast_page).to be_displayed
  end

  it 'displays proper fields' do
    expect( podcast_page ).to have_soc_list

    expect( podcast_page.podcast.title ).to have_content(podcast.name)
    expect( podcast_page.podcast.short_description ).to have_content(podcast.meta_description)
    expect( podcast_page.podcast.description ).to have_content(podcast.description)

    expect( podcast_page.podcast.logo[:src] ).to have_content(podcast.normal_path)
    expect( podcast_page.header_page_image[:style] ).to have_content( podcast.wallpaper_path )
  end

  it 'displays proper content' do
    dates = podcast.episodes.all.map{|e| e.release_date}
    dates.sort!{|a, b| b<=>a }
    release_dates = podcast_page.episodes.media_item.map{|i| i.release_date.text}
    expect(release_dates).to match_array dates.map{ |d| d.strftime("%m/%d/%Y")}
  end
end

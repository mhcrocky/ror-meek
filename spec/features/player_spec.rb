require 'rails_helper'

feature 'Player Page', js: true, type: :feature do
  let!(:user) { create :confirmed_user }

  let!(:podcast_category) { create :category, kind: 1 }
  let!(:podcast)  { create :podcast, category_id: podcast_category.id, private: false }
  let!(:podcast2) { create :podcast, category_id: podcast_category.id, private: true }
  let!(:podcast3) { create :podcast, category_id: podcast_category.id, private: true }

  let!(:episode1) { create :episode, podcast: podcast }
  let!(:episode2) { create :episode, podcast: podcast }
  let!(:episode3) { create :episode, podcast: podcast }

  let!(:episode4) { create :episode, podcast: podcast2 }

  let!(:episode5) { create :episode, podcast: podcast3, video: true }

  let!(:podcast_page) { PodcastPage.new }
    
  describe 'for logged in user' do
    before do
      sign_in(user)
      podcast_page.load(category_slug: podcast_category.slug, slug: podcast.slug)
    end

    it 'shows player' do
      expect(podcast_page).to have_no_player
      podcast_page.podcast.play_button.click
      expect(podcast_page).to have_player
      expect( podcast_page.player.image[:src] ).to include( podcast.normal_path )
      expect( podcast_page.player.title ).to have_text( podcast.name )
    end
  end

  describe 'for logged out user and non-pivate podcast' do
    before do
      podcast_page.load(category_slug: podcast_category.slug, slug: podcast.slug)
    end

    it 'show player' do
      expect(podcast_page).to have_no_player
      podcast_page.podcast.play_button.click
      expect(podcast_page).to have_player
      expect( podcast_page.player.image[:src] ).to include( podcast.normal_path )
      expect( podcast_page.player.title ).to have_text( podcast.name )
    end
  end
  
  describe 'for logged out user and private podcast' do
    before do     
      podcast_page.load(category_slug: podcast_category.slug, slug: podcast2.slug)
    end

    it 'shows Sign In modal' do      
      podcast_page.podcast.play_button.click      
      expect(podcast_page).to have_text('SIGN IN WITH')
    end
  end

  describe 'for logged out user and private podcast with video' do
    before do
      podcast_page.load(category_slug: podcast_category.slug, slug: podcast3.slug)
    end

    it 'shows Sign In modal' do
      podcast_page.podcast.play_button.click
      expect(podcast_page).to have_text('SIGN IN WITH')
    end
  end
end

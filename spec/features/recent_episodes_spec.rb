require 'rails_helper'

feature 'RecentEpisodes', js: true, type: :feature do
  let(:podcast_category) { create :category, kind: 1 }  
  let(:podcast1)         { create :podcast, category_id: podcast_category.id, name: 'Podcast1' }
  let(:podcast2)         { create :podcast, category_id: podcast_category.id, name: 'Podcast2' }
  let(:podcast3)         { create :podcast, category_id: podcast_category.id, name: 'Podcast3' }
  let!(:episode1)        { create :episode, podcast: podcast1, name: 'Episode1', release_date: 'Tue, 17 Mar 2022' }
  let!(:episode2)        { create :episode, podcast: podcast1, name: 'Episose2', release_date: 'Tue, 17 Mar 2015' }
  let!(:episode3)        { create :episode, podcast: podcast1, name: 'Episode3', release_date: 'Tue, 17 Mar 2015' }
  let!(:episode4)        { create :episode, podcast: podcast2, name: 'Episode4', release_date: 'Tue, 17 Mar 2022' }
  let!(:episode5)        { create :episode, podcast: podcast2, name: 'Episode5', release_date: 'Tue, 17 Mar 2014' }
  let!(:episode6)        { create :episode, podcast: podcast2, name: 'Episode6', release_date: 'Tue, 17 Mar 2014' }
  let!(:episode7)        { create :episode, podcast: podcast3, name: 'Episode7', release_date: 'Tue, 24 Mar 2014' }
  let!(:episode8)        { create :episode, podcast: podcast3, name: 'Episode8', release_date: 'Tue, 17 Mar 2014' }
  let(:user)             { create :confirmed_user }
  let!(:favorite1)       { create :favorite, favoritable_id: podcast1.id, favoritable_type: 'Podcast', user_id: user.id }
  let!(:favorite2)       { create :favorite, favoritable_id: podcast2.id, favoritable_type: 'Podcast', user_id: user.id } 
  let(:home_page)        { HomePage.new }
  
  context 'recent episodes for logged in user' do
    before do
      sign_in(user)
      home_page.load
    end

    it 'should show the recent episode for each favorite podcast' do
      expect(home_page.recent_episodes_block).to have_text('RECENT EPISODES')
      expect(home_page.recent_episodes_block).to have_text('Episode1')
      expect(home_page.recent_episodes_block).to have_text('Episode4')
      expect(home_page.recent_episodes_block).not_to have_text('Episode2')
      expect(home_page.recent_episodes_block).not_to have_text('Episode3')
      expect(home_page.recent_episodes_block).not_to have_text('Episode5')
      expect(home_page.recent_episodes_block).not_to have_text('Episode6')
      expect(home_page.recent_episodes_block).not_to have_text('Episode7')
      expect(home_page.recent_episodes_block).not_to have_text('Episode8')    
    end
  end

  context 'recent episodes for logged out user' do
    before do
      home_page.load
    end

    it 'should not show recent episodes' do
      expect(home_page).not_to have_text('RECENT EPISODES')
    end
  end
end


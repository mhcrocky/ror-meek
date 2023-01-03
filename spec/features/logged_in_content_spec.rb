require 'rails_helper'

feature 'Podcast Show Page', js: true, type: :feature do
  let(:podcast_category) { create :category, kind: 1 }
  let(:podcast_page)     { PodcastPage.new }
  let(:episode_page)     { EpisodePage.new }
  let(:podcast)          { create :podcast, category_id: podcast_category.id, private: true }
  let(:podcast2)         { create :podcast, category_id: podcast_category.id, private: false }
  let!(:episode)         { create :episode, podcast_id: podcast.id, video: true }
  let!(:episode2)        { create :episode, podcast_id: podcast2.id, video: true }
  let(:user)             { create :confirmed_user }

  it 'displays login popup for logged out user and private podcast' do
    podcast_page.load(category_slug: podcast_category.slug, slug: podcast.slug)
    find('.list-media-line').click
    find('.list-media-line').click
    expect(podcast_page).to have_text('SIGN IN WITH')
  end

  it 'displays episode for logged out user and non private podcast' do
    podcast_page.load(category_slug: podcast_category.slug, slug: podcast2.slug)
    find('.list-media-line').click
    find('.list-media-line').click
    expect(podcast_page).to have_text('Episode Overview')
  end

  it 'displays episode for logged in user and private podcast' do
    sign_in(user)
    podcast_page.load(category_slug: podcast_category.slug, slug: podcast.slug)

    find('.list-media-line').click
    find('.list-media-line').click
    expect(podcast_page).to have_text('Episode Overview')
  end

  it 'displays episode for logged in user and non privatte podcast' do
    sign_in(user)
    podcast_page.load(category_slug: podcast_category.slug, slug: podcast2.slug)
    find('.list-media-line').click
    find('.list-media-line').click
    expect(podcast_page).to have_text('Episode Overview')
  end

  it 'hide video for logged out user and private podcast' do
    episode_page.load(category_slug: podcast_category.slug, slug: podcast.slug, episode_slug: episode.slug)
    expect(episode_page).to have_text('Please sign in to watch this video.')
    expect(episode_page).not_to have_text('Video')
  end

  it 'display video for logged out user and non private podcast' do
    episode_page.load(category_slug: podcast_category.slug, slug: podcast2.slug, episode_slug: episode2.slug)
    expect(episode_page).not_to have_text('Please sign in to watch this video.')
    expect(episode_page).to have_text('Video')
  end

  it 'displays video for logged in user and private podcast' do
    sign_in(user)
    episode_page.load(category_slug: podcast_category.slug, slug: podcast.slug, episode_slug: episode.slug)
    expect(episode_page).not_to have_text('Please sign in to watch this video.')
    expect(episode_page).to have_text('Video')
  end

  it 'displays video for logged in user and non private podcast' do
    sign_in(user)
    episode_page.load(category_slug: podcast_category.slug, slug: podcast2.slug, episode_slug: episode2.slug)
    expect(episode_page).not_to have_text('Please sign in to watch this video.')
    expect(episode_page).to have_text('Video')
  end
end

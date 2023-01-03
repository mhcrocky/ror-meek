require 'rails_helper'

feature 'Home page', js: true, type: :feature do
  let!(:footer)   { create :footer, title: 'Advertise', link: 'advertise' }
  let!(:footer2)  { create :footer, title: 'About Us', link: 'about' }
  let!(:footer3)  { create :footer, title: 'Terms of Use', link: 'term_of_use' }
  let!(:footer4)  { create :footer, title: 'Privacy Policy', link: 'privacy_policy' }
  let!(:footer5)  { create :footer, title: 'Contact Us', link: 'contactus' }
  let(:home_page) { HomePage.new }
  let!(:user)     { create :confirmed_user }

  before do
    home_page.load
  end

  it 'should be loaded properly' do
    sleep 1
    expect(home_page).to be_displayed
  end

  context 'header' do
    it 'should contain main header with its content' do
      expect(home_page.main_header).to be_visible
      expect(home_page.main_header.logo).to be_visible
      expect(home_page.main_header.sign_in_button).to be_visible
      expect(home_page.main_header.search_form).to be_visible
      expect(home_page.main_header.search_input).to be_visible
    end
  end

  context 'header for logged in user' do
    before do
      sign_in(user)
      home_page.load
    end

    it 'should contain preheader with its content' do
      expect(home_page).to have_text('LoggedInPreheader')
      expect(home_page).not_to have_text('LoggedOutPreheader')
    end
  end

  context 'header for logged out user' do
    before do
      home_page.load
    end

    it 'should contain preheader with its content' do
      expect(home_page).to have_text('LoggedOutPreheader')
      expect(home_page).not_to have_text('LoggedInPreheader')
    end
  end

  context 'footer' do
    it 'should be visible' do
      expect(home_page.footer.advertise_link).to be_visible
      expect(home_page.footer.about_us_link).to be_visible
      expect(home_page.footer.terms__link).to be_visible
      expect(home_page.footer.privacy_link).to be_visible
      expect(home_page.footer.contactus_link).to be_visible
    end
  end

  context 'Trending now' do
    let(:radio_station1) { create(:radio_station) }
    let(:radio_station2) { create(:radio_station) }
    let(:radio_station3) { create(:radio_station) }
    let(:podcast1) { create(:podcast) }
    let(:podcast2) { create(:podcast) }
    let(:podcast3) { create(:podcast) }
    let(:dummy_podcast) { create(:podcast) }

    let(:episode1) { create(:episode, podcast: podcast1) }
    let(:episode2) { create(:episode, podcast: podcast2) }
    let(:episode3) { create(:episode, podcast: podcast3) }

    let!(:episode4) { create(:episode, release_date: Date.today + 1, podcast: dummy_podcast) }
    let!(:episode5) { create(:episode, release_date: Date.today + 2, podcast: dummy_podcast) }
    let!(:episode6) { create(:episode, release_date: Date.today + 3, podcast: dummy_podcast) }

    before do
      create(:play, media: radio_station1)
      create(:play, media: radio_station2)
      create(:play, media: radio_station3)
      create(:play, media: episode1)
      create(:play, media: episode2)
      create(:play, media: episode3)

      home_page.load
    end
  end

  context 'sidebar' do
    it 'should be visible' do
      expect(home_page.sidebar_nav.blog_link).to be_visible
    end
  end
end

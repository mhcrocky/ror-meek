require 'rails_helper'

feature 'Profile page', js: true, type: :feature do
  let(:user) { create :confirmed_user }
  let(:profile_page) { ProfilePage.new }

  before do
    sign_in(user)
    profile_page.load(slug: user.slug)
  end

  context 'Profile' do
    it 'should open Profile page' do
      expect(profile_page.header_page.breadcrumbs).to have_text('My Page')
    end

    it 'shows "Details about you" modal on click Edit "Details About You"' do
      profile_page.details_about_you_button.click
      expect(profile_page.details_about_you).to be_visible
    end

    it 'shows "Accaunt Details" modal on click Edit "Accaunt Details"' do
      profile_page.account_details_button.click
      expect(profile_page.account_details).to be_visible
    end
  end
end

require 'rails_helper'

feature 'Details about you on profile', js: true, type: :feature do
  let(:user) { create :confirmed_user }
  let(:profile_page) { ProfilePage.new }

  before do
    sign_in(user)
    profile_page.load(slug: user.slug)
  end

  it 'should have ability to update birth date' do
    profile_page.details_about_you_button.click

    profile_page.details_about_you.year.select '2012'
    profile_page.details_about_you.month.select 'April'
    profile_page.details_about_you.day.select '21'

    profile_page.details_about_you.submit.click

    expect( profile_page ).to have_text( '2012-04-21' )
  end
end

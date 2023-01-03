require 'rails_helper'

feature 'Reset password', js: true, type: :feature do
  let(:home_page) { HomePage.new }
  let!(:user) { create :confirmed_user }

  before do
    home_page.load
  end

  it 'opens reset password correctly' do
    home_page.main_header.sign_in_button.click
    home_page.sign_modal.forgot_password_link.click

    expect( home_page.reset_password_modal ).to be_visible
    expect( home_page.reset_password_modal ).to have_text('RESET YOUR PASSWORD')
  end

  it 'sends email with reset password link' do
    reset_mailer

    home_page.main_header.sign_in_button.click
    home_page.sign_modal.forgot_password_link.click

    home_page.reset_password_modal.email_field.set user.email

    home_page.reset_password_modal.submit.click

    expect(home_page.flash_container).to have_text('An email with password reset instructions has been sent to you.')

    expect( unread_emails_for(user.email).count ).to eq 1
    expect( unread_emails_for(user.email).last ).to have_subject('Reset password instructions')
    expect( unread_emails_for(user.email).last.body ).to have_text('Someone has requested a link to change your password')
    expect( unread_emails_for(user.email).last.body ).to have_text('Change my password')

    expect( unread_emails_for(user.email).last.body ).to include( "/?reset_password_token=" )
  end

end

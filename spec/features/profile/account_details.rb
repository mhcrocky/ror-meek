require 'rails_helper'

feature 'Account details on profile', js: true, type: :feature do
  before(:all) do
    RSpec::Mocks.with_temporary_scope do
      allow_any_instance_of(User).to receive(:create_customerio_subscription)
      allow_any_instance_of(User).to receive(:update_customerio_subscription)
      allow_any_instance_of(User).to receive(:remove_customerio_subscription)
    end
  end

  let(:user) { create :confirmed_user }
  let(:profile_page) { ProfilePage.new }

  before do
    sign_in(user)
    profile_page.load(slug: user.slug)
  end

  it 'shows email and full name' do
    expect( profile_page ).to have_text( user.email )
    expect( profile_page ).to have_text( user.first_name )
    expect( profile_page ).to have_text( user.last_name )
  end

  it 'can update email and full name' do
    expect( profile_page ).to_not have_text( 'newemail@gmail.com' )
    expect( profile_page ).to_not have_text( 'Vasia' )
    expect( profile_page ).to_not have_text( 'Pupkin' )

    profile_page.account_details_button.click

    profile_page.account_details.email.set 'newemail@gmail.com'
    profile_page.account_details.first_name.set 'Vasia'
    profile_page.account_details.last_name.set 'Pupkin'

    profile_page.account_details.submit.click

    expect( profile_page ).to have_text( 'newemail@gmail.com' )
    expect( profile_page ).to have_text( 'Vasia' )
    expect( profile_page ).to have_text( 'Pupkin' )
  end

  it 'can"t save blank email' do
    profile_page.account_details_button.click

    profile_page.account_details.email.set ''
    profile_page.account_details.submit.click

    expect( profile_page.account_details ).to have_text( "can't be blank" )
  end

  context 'Email changing' do

    it 'does not change users email' do
      expect( profile_page ).to have_text( user.email )

      profile_page.account_details_button.click

      expect( profile_page.account_details.email.value ).to eq(user.email)
      profile_page.account_details.email.set 'newemail@gmail.com'
      profile_page.account_details.submit.click

      expect( profile_page ).to have_text( user.email )

      profile_page.account_details_button.click
      expect( profile_page.account_details.email.value ).to eq(user.email)
    end

    it 'shows unconfirmed email on the page after changing email' do
      expect( profile_page ).to_not have_text( 'newemail@gmail.com' )
      expect( profile_page ).to_not have_text( 'Unconfirmed email:' )

      profile_page.account_details_button.click
      profile_page.account_details.email.set 'newemail@gmail.com'
      profile_page.account_details.submit.click

      expect( profile_page ).to have_text( 'newemail@gmail.com' )
      expect( profile_page ).to have_text( 'Unconfirmed email:' )
    end

    it 'does not sends email to unconfirmed email' do
      expect {
        profile_page.account_details_button.click
        profile_page.account_details.email.set 'newemail@gmail.com'
        profile_page.account_details.submit.click
        expect( profile_page ).to have_text( 'Unconfirmed email:' )

        user.reload
      }.to change {
        unread_emails_for(user.email).count
      }.by(0)
    end

    it 'sends email to unconfirmed email' do
      expect {
        profile_page.account_details_button.click
        profile_page.account_details.email.set 'newemail@gmail.com'
        profile_page.account_details.submit.click
        expect( profile_page ).to have_text( 'Unconfirmed email:' )

        user.reload
      }.to change {
        unread_emails_for(user.unconfirmed_email).count
      }.by(1)

      expect( unread_emails_for( user.unconfirmed_email ).last ).to have_subject('Confirmation instructions')
      expect( unread_emails_for( user.unconfirmed_email ).last.body ).to have_text('You can confirm your account email through the link below')
      expect( unread_emails_for( user.unconfirmed_email ).last.body ).to have_text('Confirm my account')

      expect( unread_emails_for( user.unconfirmed_email ).last.body ).to include( "/api/users/confirmation?confirmation_token=#{user.confirmation_token}" )
    end

    it 'generate another token for each changing of email' do
      expect {
        profile_page.account_details_button.click
        profile_page.account_details.email.set( 'newemail@gmail.com' )
        profile_page.account_details.submit.click
        expect( profile_page ).to have_text( 'newemail@gmail.com' )

        user.reload
      }.to change {
        unread_emails_for( 'newemail@gmail.com' ).count
      }.by(1)

      expect {
        profile_page.account_details_button.click
        profile_page.account_details.email.set( 'another@gmail.com' )
        profile_page.account_details.submit.click
        expect( profile_page ).to have_text( 'another@gmail.com' )
        expect( profile_page ).to_not have_text( 'newemail@gmail.com' )

        user.reload
      }.to change {
        unread_emails_for( 'another@gmail.com' ).count
      }.by(1)

    end
  end
end

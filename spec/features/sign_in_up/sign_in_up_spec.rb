require 'rails_helper'
SETUP_PAGE_CONTENT = '<h1 style="font-family:Bungee;">Setup Free Meek Account</h1><h3>Meek is '\
                   'free for your personal use. To gain access to store things like your Favorite'\
                   'podcasts and radio stations, you just need to sign up.</h3><p>'\
                   '##SIGNUP##<br></p><h3><br></h3><p><br></p>'

feature 'Sign in - up', js: true, type: :feature do
  let(:profile_page) { ProfilePage.new }
  let(:home_page) { HomePage.new }
  let(:sign_up_page) { SignUpPage.new }
  let!(:user) { create :confirmed_user, first_name: 'First', last_name: 'Last' }
  let!(:setup_page) { create :landing_page, slug: 'setup', content: SETUP_PAGE_CONTENT }
  let!(:thank_you_page) { create :landing_page, slug: 'thank-you', content: 'ty' }
  let(:random_email) { Faker::Internet.email }
  let(:random_password) { Faker::Internet.password }
  let(:random_first_name) { Faker::Name.first_name }
  let(:random_last_name) { Faker::Name.last_name }

  before do
    home_page.load
  end

  it 'should open sign up-in modal' do
    home_page.main_header.sign_in_button.click
    expect(home_page.sign_modal).to be_visible
  end

  describe 'Sign up' do
    before do
      sign_up_page.load
      sign_up_page.email_field.set random_email
      sign_up_page.password_field.set random_password
      sign_up_page.confirmation_password_field.set random_password
      sign_up_page.first_name_field.set random_first_name
      sign_up_page.last_name_field.set random_last_name

      sign_up_page.submit.click
    end

    it 'should receive confirmation email' do
      expect(page).to have_text('ty')

      expect( unread_emails_for(user.email).count ).to eq 1
      expect( unread_emails_for(user.email).last ).to have_subject('Confirmation instructions')
      expect( unread_emails_for(user.email).last.body ).to have_text('You can confirm your account email through the link below')
      expect( unread_emails_for(user.email).last.body ).to have_text('Confirm my account')

      expect( unread_emails_for(user.email).last.body ).to include( "/api/users/confirmation?confirmation_token=#{user.confirmation_token}" )
    end

    context 'With errors' do
      it 'shows error if email has already been taken' do
        sign_up_page.load
        sign_up_page.email_field.set user.email
        sign_up_page.password_field.set user.password
        sign_up_page.confirmation_password_field.set user.password
        sign_up_page.first_name_field.set user.first_name
        sign_up_page.last_name_field.set user.last_name

        sign_up_page.submit.click

        expect(sign_up_page).to have_text('has already been taken')
      end
    end
  end

  describe 'Sign in' do
    it 'should sign in correctly' do
      home_page.main_header.sign_in_button.click
      expect(home_page.sign_modal).to have_text('SIGN IN WITH')
      home_page.sign_modal.email_field.set user.email
      home_page.sign_modal.password_field.set user.password

      home_page.sign_modal.submit.click

      expect(home_page.flash_container).to have_text('Welcome back!')
      expect(home_page.main_header.head_avatar.visible?).to be_truthy
    end
  end

  describe 'Logout' do
    let!(:confirmed_user) { create :confirmed_user }

    before do
      sign_in(confirmed_user)
      home_page.load
    end

    it 'should logout correctly' do
      profile_page.main_header.head_avatar.click
      home_page.main_header.logout_button.click
      expect(home_page.flash_container).to have_text('You have been logged out')
      expect(home_page.main_header).to_not have_head_avatar
    end
  end

  describe 'Confirm' do
    def confirm_account_and_redirect(token)
      visit user_confirmation_path(confirmation_token: token)
    end

    let!(:confirmed_user) { create :confirmed_user }
    let!(:unconfirmed_user) { create :unconfirmed_user }

    it 'successfully confirms user' do
      expect {
        confirm_account_and_redirect(unconfirmed_user.confirmation_token)
        unconfirmed_user.reload
      }.to change {
        unconfirmed_user.confirmed_at
      }.from(nil).to(Object)

      expect(home_page).to be_displayed

      expect(home_page.flash_container).to have_text('Email address confirmed')
      expect(home_page.main_header.head_avatar.visible?).to be_truthy
    end

    it 'shows error message with wrong token' do
      confirm_account_and_redirect( unconfirmed_user.confirmation_token + 'blahblah' )

      expect(home_page).to be_displayed
      expect(home_page.flash_container).to have_text('Confirmation token is invalid')
      expect(home_page.main_header).to_not have_head_avatar
    end

    it 'shows error message for already confirmed user' do
      confirm_account_and_redirect(confirmed_user.confirmation_token)

      expect(home_page).to be_displayed

      expect(home_page.flash_container).to have_text('Email was already confirmed, please try signing in')

      expect(home_page.main_header).to_not have_head_avatar
    end

    context 'User logged in as confirmed_user but try to confirm un_confirmed_user' do
      before do
        sign_in confirmed_user
        profile_page.load(slug: confirmed_user.slug)
      end

      it 'should successfully confirm un_confirmed_user but stay logged in as confirmed_user' do
        expect(profile_page).to have_text( confirmed_user.full_name )

        expect {
          confirm_account_and_redirect(unconfirmed_user.confirmation_token)
          unconfirmed_user.reload
        }.to change {
          unconfirmed_user.confirmed_at
        }.from(nil).to(Object)

        expect(home_page.flash_container).to have_text('Email address confirmed')
        profile_page.load(slug: confirmed_user.slug)

        expect(profile_page).to have_text( confirmed_user.full_name )
      end
    end
  end

  describe 'Reconfirm' do

    it 'checks existing of reconfirm link of sign in modal' do
      home_page.main_header.sign_in_button.click
      expect(home_page.sign_modal.reconfirm_link).to be_visible
    end

    it 'shows modal on reconfirm link click' do
      home_page.main_header.sign_in_button.click
      expect(home_page.sign_modal).to be_visible
      home_page.sign_modal.reconfirm_link.click
      expect(home_page.reconfirm_modal).to be_visible
    end

    context 'for unconfirmed users' do
      let!(:unconfirmed_user) { create :unconfirmed_user }

      before do
        home_page.main_header.sign_in_button.click
        home_page.sign_modal.reconfirm_link.click
      end

      it 'shows message "Already confirmed"' do
        home_page.reconfirm_modal.email_field.set unconfirmed_user.email

        home_page.reconfirm_modal.submit.click
        expect(home_page.flash_container).to have_text('An email with confirmation link has been sent to you.')

        expect( unread_emails_for(user.email).count ).to eq 1
        expect( unread_emails_for(user.email).last ).to have_subject('Confirmation instructions')
        expect( unread_emails_for(user.email).last.body ).to have_text('You can confirm your account email through the link below')
        expect( unread_emails_for(user.email).last.body ).to have_text('Confirm my account')

        expect( unread_emails_for(user.email).last.body ).to include( "/api/users/confirmation?confirmation_token=#{user.confirmation_token}" )
      end
    end

    context 'for confirmed users' do
      let!(:confirmed_user) { create :confirmed_user }

      before do
        home_page.main_header.sign_in_button.click
        expect(home_page.sign_modal).to be_visible
        home_page.sign_modal.reconfirm_link.click
        expect(home_page.reconfirm_modal).to be_visible
      end

      it 'shows message "Already confirmed"' do
        home_page.reconfirm_modal.email_field.set confirmed_user.email

        expect {
          home_page.reconfirm_modal.submit.click
        }.to change {
          unread_emails_for(user.email).count
        }.by(0)

        expect( home_page.reconfirm_modal ).to have_text('was already confirmed, please try signing in')
      end
    end


    context 'for nonexisting user' do
      before do
        home_page.main_header.sign_in_button.click
        expect(home_page.sign_modal).to be_visible
        home_page.sign_modal.reconfirm_link.click
        expect(home_page.reconfirm_modal).to be_visible
      end

      it 'shows error message' do
        home_page.reconfirm_modal.email_field.set 'non_exist_user@gmail.com'

        expect {
          home_page.reconfirm_modal.submit.click
        }.to change {
          unread_emails_for(user.email).count
        }.by(0)

        expect( home_page.reconfirm_modal ).to have_text('not found')
      end
    end
  end

  describe 'Relogin after changing email' do
    let(:profile_page) { ProfilePage.new }
    let!(:confirmed_user) { create :confirmed_user }

    before do
      # Sign In
      sign_in(confirmed_user)

      profile_page.load(slug: confirmed_user.slug)

      # Change Email
      profile_page.account_details_button.click
      profile_page.account_details.email.set 'newemail@gmail.com'
      profile_page.account_details.submit.click
      expect( profile_page ).to have_text( 'newemail@gmail.com' )

      confirmed_user.reload

      # LogOut
      profile_page.main_header.head_avatar.click
      profile_page.main_header.logout_button.click
      expect(home_page.flash_container).to have_text('You have been logged out')
    end

    it 'unconfirmed_user can login by main email' do
      home_page.main_header.sign_in_button.click
      home_page.sign_modal.email_field.set( confirmed_user.email )
      home_page.sign_modal.password_field.set( confirmed_user.password )

      home_page.sign_modal.submit.click

      expect(home_page.flash_container).to have_text('Welcome back!')
    end

    it 'unconfirmed_user can not login by unconfirmed email' do
      home_page.main_header.sign_in_button.click
      home_page.sign_modal.email_field.set( confirmed_user.unconfirmed_email )
      home_page.sign_modal.password_field.set( confirmed_user.password )

      home_page.sign_modal.submit.click

      expect(home_page.sign_modal).to have_text('Invalid email or password.')
    end
  end
end

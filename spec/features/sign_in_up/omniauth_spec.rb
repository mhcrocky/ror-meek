require 'rails_helper'

feature 'Omniauth', js: true, type: :feature do
  let(:home_page) { HomePage.new }

  before do
    home_page.load
  end

  describe 'Login via Identity' do

    context 'By Facebook' do
      def attempt_to_login
        home_page.main_header.sign_in_button.click
        home_page.sign_modal.facebook.click
        sleep 1
      end

      before do
        facebook_mock_auth_hash
      end

      it 'logins correctly' do
        attempt_to_login
        expect(home_page.main_header.head_avatar.visible?).to be_truthy
      end

      it 'creates new user' do
        expect {
          attempt_to_login
        }.to change {
          User.count
        }.from(0).to(1)
      end

      it 'creates identity' do
        expect {
          attempt_to_login
        }.to change {
          Identity.count
        }.from(0).to(1)
      end

      it 'ties identity and account' do
        attempt_to_login

        expect( Identity.find_by(email: 'dmytro.vasin@gmail.com').user_id ).to eq( User.find_by(email: 'dmytro.vasin@gmail.com').id )
      end

      it 'does not send email' do
        expect {
          attempt_to_login
        }.to change {
          unread_emails_for('dmytro.vasin@gmail.com').count
        }.by(0)
      end

      context 'If user exist' do
        before do
          create :confirmed_user, email: 'dmytro.vasin@gmail.com'
        end

        it 'applies it' do
          expect {
            attempt_to_login
          }.to change {
            User.count
          }.by(0)
        end
      end

      context 'If identity exist' do
        before do
          create :identity, provider: 'facebook', uid: '54321'
        end

        it 'applies it' do
          expect {
            attempt_to_login
          }.to change {
            Identity.count
          }.by(0)
        end
      end

      context 'Confirm users' do
        context 'for new user' do

          it 'confirms user' do
            attempt_to_login
            expect( User.find_by(email: 'dmytro.vasin@gmail.com').confirmed? ).to be_truthy
          end
        end

        context 'for unconfirmed user' do
          let!(:unconfirmed_user) { create :unconfirmed_user, email: 'dmytro.vasin@gmail.com' }

          it 'confirms user' do
            attempt_to_login
            unconfirmed_user.reload
            expect( unconfirmed_user.confirmed? ).to be_truthy
          end
        end
      end
    end

    context 'By Twitter' do
      def attempt_to_login
        home_page.main_header.sign_in_button.click
        home_page.sign_modal.twitter.click
        sleep 1
      end

      before do
        twitter_mock_auth_hash
      end

      it 'logins correctly' do
        attempt_to_login
        expect(home_page.main_header.head_avatar.visible?).to be_truthy
      end

      it 'creates new user' do
        expect {
          attempt_to_login
        }.to change {
          User.count
        }.from(0).to(1)
      end

      it 'creates identity' do
        expect {
          attempt_to_login
        }.to change {
          Identity.count
        }.from(0).to(1)
      end

      it 'ties identity and account' do
        attempt_to_login
        expect( Identity.find_by(name: 'Vasin Dima').user_id ).to eq( User.find_by(first_name: 'Vasin', last_name: 'Dima').id )
      end

      it 'does not send email' do
        expect {
          attempt_to_login
        }.to change {
          unread_emails_for('dmytro.vasin@gmail.com').count
        }.by(0)
      end

      context 'If user exist' do
        xit 'applies it' do
          # Twitter does not have an email
        end
      end

      context 'If identity exist' do
        before do
          create :identity, provider: 'twitter', uid: '123545'
        end

        it 'applies it' do
          expect {
            attempt_to_login
          }.to change {
            Identity.count
          }.by(0)
        end
      end

      context 'Confirm users' do
        context 'for new user' do
          it 'confirms user' do
            attempt_to_login

            expect( User.find_by(first_name: 'Vasin', last_name: 'Dima').confirmed? ).to be_truthy
          end
        end

        context 'for unconfirmed user' do
          xit 'confirms user' do
            # Twitter does not have an email
          end
        end
      end
    end

  end
end

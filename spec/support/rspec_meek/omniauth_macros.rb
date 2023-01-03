module RspecMeek
  module OmniauthMacros

    def twitter_mock_auth_hash
      OmniAuth.config.mock_auth[:default] = OmniAuth::AuthHash.new({
        provider: 'twitter',
        uid: '123545',

        info: {
          name: 'Vasin Dima'
        }
      })
    end

    def facebook_mock_auth_hash
      OmniAuth.config.mock_auth[:default] = OmniAuth::AuthHash.new({
        provider: 'facebook',
        uid: '54321',

        info: {
          email: 'dmytro.vasin@gmail.com',
          name: 'Dmitriy Vasin'
        }
      })
    end
  end
end


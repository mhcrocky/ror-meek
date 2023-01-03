ENV['RAILS_ENV'] ||= 'test'

require 'spec_helper'
require File.expand_path('../../config/environment', __FILE__)
require 'rspec/rails'
require 'capybara/rspec'
require 'capybara/poltergeist'
require 'capybara-screenshot/rspec'
require 'factory_bot'
require 'factory_bot_rails'
require 'devise'
require 'capybara/poltergeist'
require 'site_prism'
require 'email_spec'
require 'webmock/rspec'

# Simplecov:
require 'simplecov'

include ActionDispatch::TestProcess

WebMock.disable_net_connect!(allow_localhost: true)

SimpleCov.formatters = [
  SimpleCov::Formatter::HTMLFormatter
]

SimpleCov.start 'rails'

ActiveRecord::Migration.maintain_test_schema!

Dir['spec/support/**/*.rb'].each do |file|
  require Rails.root.join(file).to_s
end

RSpec.configure do |config|
  config.include Devise::TestHelpers, type: :controller
  config.include Warden::Test::Helpers
  config.include FactoryBot::Syntax::Methods
  config.include ActionDispatch::TestProcess, type: :feature
  config.include EmailSpec::Helpers
  config.include EmailSpec::Matchers
  config.include RspecMeek::Helpers, type: :feature
  config.include Request::Helpers, type: :request
  config.include RspecMeek::OmniauthMacros
  config.include ActionDispatch::TestProcess

  config.use_transactional_fixtures = false
  config.infer_spec_type_from_file_location!

  Warden.test_mode!
  config.after :each do
    Warden.test_reset!
    reset_mailer
  end

  Capybara.javascript_driver = :selenium_chrome_headless
  #Capybara.javascript_driver = :selenium_chrome
  #Capybara.default_max_wait_time = 5

  Capybara.ignore_hidden_elements = true

  Capybara.server = :webrick
  config.before :each do
    if Capybara.current_driver == :rack_test
      DatabaseCleaner.strategy = :transaction
    else
      DatabaseCleaner.strategy = :deletion
    end
    DatabaseCleaner.start

    create(:background)
  end

  config.after do
    DatabaseCleaner.clean
  end
end

OmniAuth.config.test_mode = true

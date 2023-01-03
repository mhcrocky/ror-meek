source 'https://rubygems.org'
ruby '3.1.3'

#gem 'rails', '4.2.11'
gem 'rails', '~> 7.0', '>= 7.0.4'

#gem 'pg', '~> 0.15.0'
gem 'pg', '~> 1.4', '>= 1.4.5'

# BB CANT be newer else YAML issues apepar at gem install
gem 'psych', '~> 4.0', '>= 4.0.5'
gem 'rdoc', '~> 6.3', '>= 6.3.1'

gem 'haml'
#gem 'sass-rails', '~> 5.0.4'
gem 'sass-rails', '~> 6.0'
gem 'uglifier'
#gem 'coffee-rails', '~> 4.0.0'
gem 'coffee-rails', '~> 5.0'
gem 'font-awesome-sass', '~> 4.4.0'
#gem 'activeadmin', '~> 1.4', '>= 1.4.3'
gem 'activeadmin', '~> 2.13', '>= 2.13.1'
#gem 'activeadmin_trumbowyg'
gem 'activeadmin_trumbowyg', '~> 1.0'
#gem 'friendly_id', '~> 5.0.4'
gem 'friendly_id', '~> 5.4', '>= 5.4.2'
#gem 'jbuilder', '~> 2.2.8'
gem 'jbuilder', '~> 2.11', '>= 2.11.5'
#gem 'kaminari'
gem 'kaminari', '~> 1.2', '>= 1.2.2'

#gem 'mimemagic', github: 'mimemagicrb/mimemagic', ref: '3543363026121ee28d98dfce4cb6366980c055ee'
#gem 'mimemagic'
gem 'mimemagic', '~> 0.4.3'

# BB
#gem 'eventmachine', '~> 1.2', '>= 1.2.7'
#gem 'eventmachine', '~> 1.0', '>= 1.0.9.1'
gem 'eventmachine', '~> 1.2', '>= 1.2.7'
gem 'open-uri', '~> 0.3.0'

# BB for newer bundler
#gem 'bundler', '2.0.0.pre.3'
gem 'bundler', '~> 2.3', '>= 2.3.25'

gem 'newrelic_rpm'
#gem 'paperclip'
#gem 'paperclip', '~> 6.1'
# paperclip gem has licensing issues and was yanked from the gem repository, kt replacing it
gem 'kt-paperclip', '~> 7.1', '>= 7.1.1'
gem 'prerender_rails'
gem 'resque'
gem 'resque-web', require: 'resque_web'
gem 'resque_mailer'
#gem 'sinatra', require: nil
gem 'sinatra', '~> 3.0', '>= 3.0.2'
gem 'shoutout'
gem 'rufus-scheduler'
gem 'customerio'
gem 'htmlentities'
gem 'rubyzip'

gem 'down'
gem 'google-cloud-storage'
gem 'google-cloud-speech'

gem 'browserify-rails'

# Pinned to 3.x as newer requires a lot of updates in the manifest:
# ref: https://stackoverflow.com/questions/58339607/why-does-rails-fails-to-boot-with-expected-to-find-a-manifest-file-in-app-asse
gem 'sprockets', '~>3.0'

# AngularJS
gem 'angular-rails-templates'
#gem 'angular_rails_csrf', '~> 2.1'
gem 'angular_rails_csrf', '~> 5.0'

# Authentication
#gem 'devise', '~> 3.5.2'
gem 'devise', '~> 4.8', '>= 4.8.1'
gem 'omniauth'
gem 'omniauth-twitter'
gem 'omniauth-facebook'

#gem 'unicorn'
platforms :ruby do
  gem 'rmagick', '~> 4.2', '>= 4.2.4'
  gem 'unicorn'
end
platforms :mswin do
  gem 'thin', '~> 1.8', '>= 1.8.1'
end

#gem 'rmagick', '~> 4.2', '>= 4.2.4' # moved to linux only
gem 'yt'
gem 'yt-url'
gem 'httparty'
#gem "koala", "~> 2.2"
gem 'koala', '~> 3.3'
#gem 'responders', '~> 2.0'
gem 'responders', '~> 3.0', '>= 3.0.1'

# BB Added to fix migration to ruby and rails update
gem 'activesupport', '~> 7.0', '>= 7.0.4'
gem 'bigdecimal', '~> 3.1', '>= 3.1.2'

# Added to support latest rails timezone requirement
gem 'tzinfo-data', '~> 1.2022', '>= 1.2022.6'

group :production do
  gem 'rails_12factor'
  gem 'ngannotate-rails'
end

group :development do
  gem 'rb-readline'
  gem 'better_errors'
  gem 'binding_of_caller'
  #gem 'quiet_assets'  # removed as VERY deprecated Gem
  #gem 'activerecord-colored_log_subscriber' # removed as VERY deprecated Gem

  # Capistrano Deployments
  #gem 'capistrano', '= 3.3.3'
  gem 'capistrano', '~> 3.17', '>= 3.17.1'
  #gem 'capistrano-bundler', '~> 1.1.3'
  gem 'capistrano-bundler', '~> 2.1'
  #gem 'capistrano-rails', '~> 1.1.2'
  gem 'capistrano-rails', '~> 1.6', '>= 1.6.2'
  # gem 'capistrano-rvm', '~> 0.1.2'
  #gem 'capistrano-rbenv', '~> 2.0'
  gem 'capistrano-rbenv', '~> 2.2'
  gem 'capistrano-resque', "~> 0.2.2", require: false
  # gem 'capistrano-sidekiq', '~> 0.4.0'
  # gem 'capistrano-passenger', '~> 0.0.1'
  gem 'capistrano-npm', '~> 1.0.2'
  gem 'fontcustom'
  #gem 'mailcatcher'
  #gem 'mailcatcher', '~> 0.8.2' #Gem is seldom updated and poses upgrade impediments
  #gem 'web-console', '~> 2.0'
  gem 'web-console', '~> 4.2'
end

group :test, :development do
  gem 'figaro'
  gem 'awesome_print'
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'pry-rails'
  gem 'pry',      require: false
  gem 'hirb',     require: false
  gem 'pry-remote',require: false
  gem 'pry-nav',   require: false
end

group :test do
  gem 'capybara'
  gem 'capybara-screenshot'
  gem 'database_cleaner'
  gem 'rspec-rails'
  gem 'selenium-webdriver'
  gem 'factory_bot'
  gem 'poltergeist'
  gem 'site_prism'
  gem 'simplecov', require: false
  gem 'email_spec'
  gem 'webmock'
  gem 'timecop'
end

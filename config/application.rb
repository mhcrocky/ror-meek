require_relative "boot"

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
# require "active_storage/engine"
require "action_controller/railtie"
require "action_mailer/railtie"
# require "action_mailbox/engine"
# require "action_text/engine"
require "action_view/railtie"
# require "action_cable/engine"
# require "rails/test_unit/railtie"
require 'sprockets/railtie'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Meek
  class Application < Rails::Application

    # DEV web console white listed IPS
    config.web_console.whitelisted_ips = '172.0.0.0/8'

    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.0

    #BB Added below
    config.middleware.use Rack::Deflater

    config.assets.prefix = '/assets'

    # Fonts
    config.assets.paths << Rails.root.join('app', 'assets', 'fonts')
    config.assets.paths << Rails.root.join('node_modules')

    # # Include queries
    # config.autoload_paths << File.join(config.root, 'app/queries/*.*')
    config.autoload_paths << Rails.root.join('lib')
    # Use babel in asset precompilation
    config.browserify_rails.commandline_options = '-t coffeeify -t babelify -t loose-envify'
    config.browserify_rails.source_map_environments << ['development', 'test']
    config.browserify_rails.paths = [
        ->(p) {p.start_with?(Rails.root.join('app/assets/javascripts').to_s)},
        ->(p) {p.start_with?(Rails.root.join('node_modules').to_s)}
    ]
    config.browserify_rails.node_env = Rails.env.production? ? 'production' : 'development'

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    # Don't generate system test files.
    config.generators.system_tests = nil
  end
end

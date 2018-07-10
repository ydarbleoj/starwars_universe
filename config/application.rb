require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module StarWarsUniverse
  class Application < Rails::Application

    config.autoload_paths += %W(#{config.root}/services)
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2
    config.middleware.insert_before 0, Rack::Cors, debug: true, logger: (-> { Rails.logger }) do
      allow do
        origins 'http://localhost:3000'
        resource '/api/v1/*',
          headers: ['Origin', 'Accept', 'Content-Type', 'X-Requested-With'],
          methods: [:get, :options, :post],
          credentials: false
      end

      allow do
        origins 'https://swapi.co/api/'
        resource '*',
        headers: ['Content-Type'],
        methods: [:get, :options, :post]
      end
    end

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  end
end

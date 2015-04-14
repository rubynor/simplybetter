require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)

module SimplyBetter
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    config.generators do |g|
      g.template_engine     :haml
      g.test_framework      :rspec
      g.fixture_replacement :machinist
      g.stylesheets         false
      g.helper              false
    end

    config.middleware.use Rack::Cors do
      allow do
        origins '*'
        resource '*', :headers => :any, :methods => [:get, :post, :options]
      end
    end

    config.assets.precompile += ['jquery.js']
    config.assets.precompile += %w( widget/widget.css landing_page.css landing.js widget.js )
  end
end

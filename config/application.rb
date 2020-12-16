require_relative "boot"

require "rails/all"

ENV["FAILBOT_BACKEND"] ||= "memory"
require "failbot_rails"
FailbotRails.setup("opensourcefriday")

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Ossfriday
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
  end
end

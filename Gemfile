source "https://rubygems.org"

ruby File.read(
  File.expand_path("#{File.dirname(__FILE__)}/.ruby-version")
).strip

# Include https://github.com/heartcombo/devise/pull/5327 for OmniAuth 2
gem "devise"
gem "devise-i18n"
gem "faraday-http-cache"
gem "jquery-rails"
gem "octicons_helper"
gem "octokit"
gem "omniauth-github"
gem "omniauth-rails_csrf_protection"
gem "pg"
gem "puma"
gem "rack-host-redirect"
gem "rails", "~> 7.0"
gem "rtl"
gem "sassc-rails"
gem "sitemap_generator"
gem "turbolinks"
gem "uglifier"

group :development, :test do
  gem "byebug"
end

group :development do
  gem "listen"
  gem "rubocop"
  gem "rubocop-performance"
  gem "rubocop-rails"
  gem "web-console"
end

group :production do
  gem "connection_pool"
  gem "dalli"
  gem "kgio"
  gem "memcachier"
  gem "rack-cache"
end

group :test do
  gem "simplecov", require: false
  gem "vcr", require: false
end

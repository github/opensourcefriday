source "https://rubygems.org"

ruby IO.read(File.expand_path("#{File.dirname(__FILE__)}/.ruby-version")).strip

gem "devise"
gem "devise-i18n"
gem "faraday-http-cache"
gem "figaro"
gem "jquery-rails"
gem "octicons_helper"
gem "octokit"
gem "omniauth-github"
gem "pg"
gem "puma"
gem "rack-host-redirect"
gem "rails"
gem "rtl"
gem "sassc-rails"
gem "sitemap_generator"
gem "turbolinks"
gem "uglifier"

group :development, :test do
  gem "byebug"
end

group :development do
  gem "awesome_print"
  gem "listen"
  gem "rubocop"
  gem "spring"
  gem "spring-watcher-listen"
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

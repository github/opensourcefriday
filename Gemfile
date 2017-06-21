source "https://rubygems.org"

ruby IO.read(File.expand_path("#{File.dirname(__FILE__)}/.ruby-version")).strip

gem "devise"
gem "failbot_rails"
gem "faraday-http-cache"
gem "figaro"
gem "jquery-rails"
gem "octicons_helper"
gem "octokit"
gem "omniauth-github"
gem "pg"
gem "puma"
gem "rails"
gem "sassc-rails"
gem "turbolinks"
gem "tzinfo-data", platforms: %i[mingw mswin x64_mingw jruby]
gem "uglifier"

group :development, :test do
  gem "byebug", platform: :mri
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
  gem "heroku-deflater"
  gem "redis-rails"
end

group :test do
  gem "codecov", require: false
  gem "vcr", require: false
end

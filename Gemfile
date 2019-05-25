source "https://rubygems.org"

ruby "2.6.3"

gem "rails", git: "https://github.com/rails/rails.git", branch: "master"

gem "pg"
gem "coffee-rails"

gem "jquery-rails"
gem "jbuilder", "~> 2.0"
gem "sdoc", "~> 0.4.0", group: :doc

gem "clearance"
gem "sprockets-rails", require: "sprockets/railtie"
gem "therubyracer"
gem "bootstrap-sass", "~> 3.3.6"
gem "sass-rails", ">= 3.2"
gem "puma"

group :development, :test do
  gem "rspec-rails"
  gem "pry"
end

group :development do
  gem "rubocop"
end

group :test do
  gem "capybara"
  gem "factory_bot_rails"
  gem "timecop"
end

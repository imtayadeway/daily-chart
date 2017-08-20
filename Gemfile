source "https://rubygems.org"

ruby "2.3.1"

gem "rails", github: "rails/rails", branch: "4-2-stable"

gem "pg"
gem "coffee-rails", "~> 4.1.0"

gem "jquery-rails"
gem "jbuilder", "~> 2.0"
gem "sdoc", "~> 0.4.0", group: :doc

gem "clearance"
gem "sprockets-rails", require: "sprockets/railtie"
gem "therubyracer"
gem "bootstrap-sass", "~> 3.3.6"
gem "sass-rails", ">= 3.2"
gem "puma"

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  gem "rspec-rails", "~> 3.0"
  gem "pry"
end

group :development do
  gem "rubocop"
  gem "annotate"
end

group :test do
  gem "capybara"
  gem "factory_girl_rails"
  gem "timecop"
end

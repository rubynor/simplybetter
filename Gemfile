source 'https://rubygems.org'

ruby '2.1.2'

gem 'rails', '4.1.4'
gem 'rack-cors', :require => 'rack/cors'

gem 'pg'
gem 'haml-rails'
gem 'rabl'
gem 'sass-rails', '~> 4.0.0'
gem 'compass-rails', "~> 1.1.2"
gem 'bootstrap-sass', '~> 3.0.3.0'
gem 'font-awesome-rails'
gem 'haml_coffee_assets', git: "https://github.com/netzpirat/haml_coffee_assets"
gem 'ng-rails-csrf'

group :production do
  gem 'newrelic_rpm'
  gem "sentry-raven"
  gem 'aws-ses', require: 'aws/ses'
end

gem 'searchkick'

gem 'gravtastic'
gem 'paper_trail', '~> 3.0.5'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'therubyracer', platforms: :ruby
gem 'jquery-rails'
gem 'jquery-rails-cdn'
gem 'enumerize'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

group :test do
  gem 'capybara'
  gem 'selenium-webdriver'
  gem 'rspec-rails'
  gem 'shoulda-matchers'
  gem 'machinist'
  gem 'database_cleaner'
  gem 'valid_attribute'
  gem 'timecop'
end

group :development do
  gem 'guard-livereload', require: false
  gem 'rack-livereload'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'letter_opener'
  # Faker, a port of Data::Faker from Perl, is used to easily generate fake data
  gem 'faker'
end
gem 'bcrypt', '~> 3.1.0'

# Use Capistrano for deployment
# gem 'capistrano', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]

group :development, :test do
  gem 'pry'
end

gem 'rack-timeout'
gem 'unicorn'
gem 'premailer-rails'
gem 'nokogiri'

group :staging,:production do
  gem 'rails_12factor'
end

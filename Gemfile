source 'https://rubygems.org'

gem 'rails', '~> 4.0.4'
gem 'rack-cors', :require => 'rack/cors'

gem 'pg'
gem 'haml-rails'
gem 'rabl'
gem 'sass-rails', '~> 4.0.0'
gem 'compass-rails', "~> 1.1.2"
gem 'bootstrap-sass', '~> 3.0.3.0'
gem 'font-awesome-rails'
gem 'react-rails'

group :production do
  gem 'newrelic_rpm'
  gem "sentry-raven"
end

gem 'searchkick'

gem 'gravtastic'
gem 'paper_trail', '~> 3.0.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'therubyracer', platforms: :ruby
gem 'jquery-rails'
gem 'turbolinks'
gem 'enumerize'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

group :test do
  gem 'rspec-rails'
  gem 'machinist'
  gem 'database_cleaner'
end

group :development do
  gem 'guard-livereload', require: false
  gem 'rack-livereload'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'letter_opener'
end
gem 'bcrypt-ruby', '~> 3.0.0'

# Use Capistrano for deployment
# gem 'capistrano', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]

group :development, :test do
  gem 'pry'
end

gem 'rack-timeout'
gem 'unicorn'


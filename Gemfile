source 'https://rubygems.org'

gem 'rails', '~>3.1.0'
gem 'bson_ext'
gem 'mongo'
gem 'toystore-mongo', :require => 'toystore-mongo'
gem 'net-ssh' # for RSA key fingerprinting
gem 'dotenv', :group => [:test, :development]

group :assets do
  gem 'sass-rails'
  gem 'compass-rails'
  gem 'coffee-rails'
  gem 'uglifier'
  gem 'hogan_assets'
end

group :development, :test do
  gem 'evergreen', :require => 'evergreen/rails'
  gem 'rspec-rails'
end

group :test do
  gem 'cucumber-rails', :require => false
  gem 'webmock'
  gem 'poltergeist'
end

group :guard do
  gem 'guard-bundler'
  gem 'guard-cucumber'
  gem 'guard-rspec'
end

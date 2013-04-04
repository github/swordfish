source 'https://rubygems.org'

ruby '1.9.3'

gem 'rails'
gem 'pg'
gem 'net-ssh' # for RSA key fingerprinting
gem 'dotenv', :group => [:test, :development]
gem 'strong_parameters'

group :assets do
  gem 'sass-rails'
  gem 'compass-rails'
  gem 'coffee-rails'
  gem 'uglifier'
  gem 'hogan_assets'
end

group :development, :test do
  gem 'rspec-rails'
  gem 'jasminerice'
  gem 'guard-jasmine'
  gem 'pry'
end

group :test do
  gem 'webmock', :require => false
  gem 'poltergeist'
  gem 'email_spec'
  gem 'database_cleaner'
  gem 'brakeman', :require => false
  gem 'launchy'
  gem 'pry'
end

group :guard do
  gem 'guard-bundler'
  gem 'guard-rspec'
end

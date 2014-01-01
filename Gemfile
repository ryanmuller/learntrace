source "http://rubygems.org"

gem "rails", "3.2.11"
gem "sass-rails"
gem "coffee-rails"
gem 'uglifier', ">= 1.0.3"
gem 'bootstrap-sass-rails'
gem 'xml-simple'

gem 'image_size'
gem 'nokogiri'
gem 'rabl'
gem 'pygments.rb'
gem 'redcarpet', "~> 2.1.1"

gem "pg", :require => "pg"

gem 'json'

gem "devise"
gem "omniauth-facebook"

gem "kaminari"
gem "carrierwave"
gem "jquery-rails", '>= 1.0.12'
gem "meta_search"

group :test, :development do
  gem "rspec-rails"
  gem "guard-rspec"
  gem "spork", "~> 1.0.0rc1"
  gem "awesome_print"
end

group :development do
  gem "mongrel", ">= 1.2.0.pre2"
  gem "chronic"
  gem "admin_view"
end

group :test do
  gem "factory_girl_rails"
  gem "cucumber-rails", :require => false
  gem "database_cleaner"
  gem "selenium-webdriver", "~> 2.18.0"
  gem "capybara"
  gem "shoulda"
  gem "email_spec"
end

group :production do
  gem "thin"
end

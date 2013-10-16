source 'https://rubygems.org'

# core gems
gem 'rails', '3.2.14'
gem 'rack-ssl', require: 'rack/ssl'
gem 'rack-protection'
# database
gem 'mysql2'
gem "pg"
gem 'activerecord-mysql-adapter'
# misc
gem 'bcrypt-ruby', '~> 3.0.0'
gem 'yajl-ruby', require: 'yajl/json_gem'
gem 'exception_notification'
# views stuff

gem 'twitter', git: "https://github.com/sferik/twitter"
gem 'jquery-rails'
gem 'bourbon'
gem 'sass-rails',   '~> 3.2.3'
gem 'anjlab-bootstrap-rails', '2.3.0.0', require: 'bootstrap-rails'
gem 'sanitize'
gem 'mobvious'
gem 'mobvious-rails'
gem 'awesome_print'
gem 'kaminari'
gem 'rinku', require: "rails_rinku" # auto_link
# third parties website and apis
gem 'koala'

# server and deploy stuff
gem 'capistrano'
gem 'therubyracer', platforms: :ruby
gem 'uglifier', '>= 1.0.3'
gem 'whenever'
gem 'capistrano'
gem 'capistrano-ext'
gem 'thin'

group :assets do
  gem 'turbo-sprockets-rails3'
end

group :test, :development do
  gem 'rspec-rails'
  gem 'fabrication'
  gem 'spork'
end
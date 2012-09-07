source 'http://rubygems.org'

# gem 'rails', :git => "git://github.com/rails/rails.git", :branch => "3-1-stable"
gem 'rails', '3.1.0'
gem 'rails_admin', :git => 'git://github.com/sferik/rails_admin.git'

group :development do
  gem 'mysql2'
  gem 'pry'
end


# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails', "  ~> 3.1.0.rc"
  gem 'coffee-rails', "~> 3.1.0.rc"
  gem 'uglifier'
end

gem 'jquery-rails'
gem 'devise', "~> 1.4.8"
gem 'cancan'
gem 'nifty-generators'
gem 'omniauth', '>= 0.2.6'
gem 'nokogiri'
gem 'chronic'
gem 'mongrel', '1.2.0.pre2'
gem 'redcarpet'
gem 'newrelic_rpm'

gem 'thin'

gem 'delayed_job'
gem 'redis'
gem 'pusher'

# gem 'resque', :require => 'resque/server'
# gem 'resque', :git => 'git://github.com/defunkt/resque.git', :require => 'resque/server'
# gem 'resque-scheduler'

group :production do
  gem 'pg'
end

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'

group :test do
  # Pretty printed test output
  gem 'turn', :require => false
  gem "mocha"
end

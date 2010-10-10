source 'http://rubygems.org'
source 'http://gems.github.com'
source :gemcutter

gem 'rails', '3.0.0'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'sqlite3-ruby', :require => 'sqlite3'
gem 'pg'
gem 'authlogic', :git => 'git://github.com/binarylogic/authlogic.git'
gem 'cancan'
gem 'will_paginate'
gem 'rubyzip'
gem 'activemerchant'
gem 'fastercsv'
gem 'russian'
gem 'nested_set'
gem 'paperclip', :git => 'git://github.com/thoughtbot/paperclip'


if RUBY_PLATFORM == 'java'
  gem 'rmagick4j', :require => 'RMagick'
  gem "json-jruby", :require => 'json'
else
  gem 'rmagick', :require => 'RMagick'
  gem "json"
end

group :development, :test do
   gem 'webrat'
   gem 'cucumber'
   gem 'cucumber-rails'
#   gem 'thoughtbot-factory_girl', :require => "factory_girl"
   gem 'rspec', '>= 1.3.0'
   gem 'rspec-rails', "2.0.0.beta.22", :git => "git://github.com/rspec/rspec-rails.git", :tag => "v2.0.0.beta.22"
#   gem 'remarkable_rails'
#   gem 'ffaker'
   gem 'mocha'
   gem 'rcov'
#   gem 'metric_fu'
end

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug'

# Bundle the extra gems:
# gem 'bj'
# gem 'nokogiri'
# gem 'sqlite3-ruby', :require => 'sqlite3'
# gem 'aws-s3', :require => 'aws/s3'

# Bundle gems for the local environment. Make sure to
# put test-only gems in this group so their generators
# and rake tasks are available in development mode:
# group :development, :test do
#   gem 'webrat'
# end

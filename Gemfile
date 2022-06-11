source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.0.4"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "7.0.3"

# Use the Puma web server [https://github.com/puma/puma]
gem "puma", "5.6.4"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false

# PostgreSQL
gem "pg"

# GraphQL
gem "graphql"

# Use Redis adapter to run Action Cable in production
gem "redis"

# Redis backed store for Rack::Cache, an HTTP cache.
gem "redis-rack-cache"

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
gem "rack-cors"

# Environment
gem "dotenv-rails"

# Track changes to your models, for auditing or versioning
gem "paper_trail"

# Paranoia is a re-implementation of acts_as_paranoid for Rails 4, 5, 6, and 7
gem "paranoia"

group :development do
  # This gem allows you to inspect graphql queries in a more readable format.
  gem 'graphql-rails_logger'

  # Annotate
  gem "annotate"
end

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "pry"

  # faker
  gem "faker"

  # factory_bot is a fixtures replacement
  gem "factory_bot_rails"

  # rspec-json_expectations
  gem "rspec-json_expectations"

  # shoulda-matchers
  gem "shoulda-matchers"

  # rspec testing framework
  %w[rspec-core rspec-expectations rspec-mocks rspec-rails rspec-support].each do |lib|
    gem lib, git: "https://github.com/rspec/#{lib}.git", branch: "main"
  end
end

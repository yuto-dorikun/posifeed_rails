source "https://rubygems.org"

ruby "3.3.5"

gem "rails", "~> 7.1.5", ">= 7.1.5.1"
gem "sprockets-rails"
gem "pg", "~> 1.1"
gem "puma", ">= 5.0"
gem "importmap-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "jbuilder"
gem "tzinfo-data", platforms: %i[ windows jruby ]
gem "bootsnap", require: false

# 認証
gem 'devise'

# UI
gem 'tailwindcss-rails'

# ページネーション  
gem 'kaminari'

group :development, :test do
  gem "debug", platforms: %i[ mri windows ]
end

group :development do
  gem "web-console"
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
end
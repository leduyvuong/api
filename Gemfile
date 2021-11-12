source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.0.2"

gem "rails", "~> 6.1.4", ">= 6.1.4.1"
gem "mysql2", "~> 0.5"
gem "puma", "~> 5.0"
gem "bootsnap", ">= 1.4.4", require: false
gem "rack-cors", "~> 1.1", ">= 1.1.1"
gem "devise", "~> 4.8"
gem "omniauth", "~> 2.0", ">= 2.0.4"
gem "omniauth-google-oauth2", "~> 1.0"
gem "omniauth-facebook", "~> 8.0"
gem "omniauth-rails_csrf_protection", "~> 1.0"
gem "omniauth-twitter", "~> 1.4"
gem "figaro", "~> 1.2"
gem "faker", "~> 2.19"
gem "bcrypt", "~> 3.1", ">= 3.1.16"
gem "jwt", "~> 2.3"
gem "will_paginate", "~> 3.3", ">= 3.3.1"
gem "activerecord-import", "~> 1.2"
gem "i18n", "~> 1.8", ">= 1.8.10"
gem "rails-i18n", "~> 6.0"

group :development, :test do
  gem "byebug", platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  gem "listen", "~> 3.3"
  gem "spring"
end

group :production do
  gem "pg", "1.1.4"
  gem "aws-sdk-s3", "~> 1.102"
end

gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]

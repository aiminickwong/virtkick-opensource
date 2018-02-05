source 'https://rubygems.org'

ruby '2.1.3'

gem 'active_hash'
gem 'activemodel'
gem 'bcrypt', '~> 3.1.7'
gem 'bootstrap-sass', '~> 3.1'
gem 'bugsnag'
gem 'coffee-rails', '~> 4.0.0'
gem 'daemons'
gem 'devise', git: 'https://github.com/plataformatec/devise.git', branch: 'lm-rails-4-2'
gem 'font-awesome-rails'
gem 'ipaddress', '~> 0.8.0'
gem 'jbuilder', '~> 2.0'
gem 'jquery-rails'
gem 'httparty'
gem 'rails', git: 'https://github.com/rails/rails.git'
gem 'twitter-bootstrap-rails-confirm', git: 'https://github.com/bluerail/twitter-bootstrap-rails-confirm.git'
gem 'rails-html-sanitizer', '~> 1.0'
gem 'rails_bootstrap_navbar'
gem 'recursive-open-struct'
gem 'sass-rails', '~> 5.0.0.beta1'
gem 'slim'
gem 'sqlite3'
gem 'therubyracer'
gem 'uglifier', '>= 1.3.0'
gem 'requirejs-rails', git: 'https://github.com/RushPL/requirejs-rails.git'

group :development, :test do
  gem 'byebug'
  gem 'rspec-rails'
  gem 'spring'
  gem 'web-console', '~> 2.0.0.beta2'
end

group :development do
  gem 'rb-fsevent', require: false
end

group :test do
  gem 'codeclimate-test-reporter'
  gem 'timecop'
end

# Gems that need to be required as last
gem 'delayed_job', git: 'https://github.com/Nowaker/delayed_job.git', branch: 'feature/exception-in-failure-hook'
gem 'delayed_job_active_record', '~> 4.0'


if File.exists?('Gemfile.local')
  eval File.read('Gemfile.local'), nil, 'Gemfile.local'
end

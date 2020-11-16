source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.1'

gem 'rails', '~> 6.0.3', '>= 6.0.3.4'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 4.1'
gem 'sass-rails', '>= 6'
gem 'webpacker', '~> 4.0'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.7'
gem 'bcrypt', '~> 3.1.7'
gem 'bootsnap', '>= 1.4.2', require: false
gem "view_component", require: "view_component/engine"
gem "pundit", "~> 2.1"
# gem 'redis', '~> 4.0'
# gem 'image_processing', '~> 1.2'

group :development, :test do
  gem "capybara", "~> 3.33"
  gem "rspec-rails", "~> 4.0", ">= 4.0.1"
  gem "shoulda-matchers", "~> 4.4", ">= 4.4.1"
  gem "factory_bot_rails", "~> 6.1"
  gem "pundit-matchers", "~> 1.6"
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  gem "guard-rspec", "~> 4.7", ">= 4.7.3"
  gem "better_errors", "~> 2.8", ">= 2.8.3"
  gem "binding_of_caller", "~> 0.8.0"
  gem "web-console", ">= 3.3.0"
  gem "bullet", "~> 6.1"
  gem "listen", "~> 3.2"
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

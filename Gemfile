# frozen_string_literal: true

source 'https://rubygems.org'

gem 'color_echo', '~> 3.1', '>= 3.1.1'
gem 'jekyll'
gem 'rubocop', '~> 0.88.0', require: false
gem 'pokemon', '>= 0.1.0'
gem 'pry', '~> 0.13.1', require: false

# Install them only on macOS
# https://bundler.io/v1.10/man/gemfile.5.html#INSTALL_IF-install_if-
install_if -> { RUBY_PLATFORM =~ /darwin/ } do
  gem 'iStats'
end

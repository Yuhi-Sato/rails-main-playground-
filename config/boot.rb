ENV["BUNDLE_GEMFILE"] ||= File.expand_path("../Gemfile", __dir__)

require "bundler/setup" # Set up gems listed in the Gemfile.
require "bootsnap/setup" # Speed up boot time by caching expensive operations.

# Auto-freeze string literals across the app in development.
require "freezolite" if ENV["RAILS_ENV"] == "development"

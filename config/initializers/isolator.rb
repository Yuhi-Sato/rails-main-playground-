return unless Rails.env.development? || Rails.env.test?

require "isolator"

Isolator.configure do |config|
  config.raise_exceptions = Rails.env.test?
end

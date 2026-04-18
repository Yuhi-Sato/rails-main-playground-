require "stoplight"

Stoplight.configure do |config|
  config.data_store = Stoplight::DataStore::Memory.new
  config.tracked_errors = [StandardError]
end

require "imgproxy"

Imgproxy.configure do |config|
  config.endpoint = ENV.fetch("IMGPROXY_URL", "https://imgproxy.yuhi.dev")
  config.key      = ENV["IMGPROXY_KEY"]
  config.salt     = ENV["IMGPROXY_SALT"]
end

class Rack::Attack
  throttle("req/ip", limit: 300, period: 5.minutes, &:ip)

  throttle("contact/ip", limit: 5, period: 1.minute) do |req|
    req.ip if req.path == "/contact" && req.post?
  end

  self.throttled_responder = lambda do |_req|
    [429, { "Content-Type" => "text/plain" }, ["Too many requests. Please slow down."]]
  end
end

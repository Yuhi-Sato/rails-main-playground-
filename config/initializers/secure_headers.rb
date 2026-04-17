SecureHeaders::Configuration.default do |config|
  config.x_frame_options = "DENY"
  config.x_content_type_options = "nosniff"
  config.x_xss_protection = "1; mode=block"
  config.referrer_policy = "strict-origin-when-cross-origin"

  config.csp = {
    default_src: %w['self'],
    img_src: %w['self' data: https:],
    style_src: %w['self' 'unsafe-inline'],
    script_src: %w['self'],
    connect_src: %w['self'],
    font_src: %w['self' data:]
  }
end

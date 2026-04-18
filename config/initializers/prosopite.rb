if Rails.env.development?
  Rails.application.config.after_initialize do
    Prosopite.rails_logger = true
    Prosopite.raise = false
  end
end

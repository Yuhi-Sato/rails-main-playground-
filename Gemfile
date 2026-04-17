source "https://rubygems.org"

ruby "3.3.6"

# =============================================================================
# Rails main branch (edge)
# =============================================================================
gem "rails", github: "rails/rails", branch: "main"
gem "propshaft"
gem "pg", "~> 1.5"
gem "puma", ">= 6.0"

# =============================================================================
# Front-end (Hotwire + Tailwind)
# =============================================================================
gem "importmap-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "tailwindcss-rails"
gem "jbuilder"

# Windows timezone data
gem "tzinfo-data", platforms: %i[windows jruby]

# Rails 8 solid adapters
gem "solid_cache"
gem "solid_queue"
gem "solid_cable"

gem "bootsnap", require: false
gem "kamal", require: false
gem "thruster", require: false
gem "image_processing", "~> 1.2"

# =============================================================================
# Gemfile of Dreams (Evil Martians)
# https://evilmartians.com/chronicles/gemfile-of-dreams-libraries-we-use-to-build-rails-apps
# =============================================================================

# --- Configuration ---------------------------------------------------------
gem "anyway_config", "~> 2.6"

# --- Authorization ---------------------------------------------------------
gem "action_policy"

# --- UI / Views ------------------------------------------------------------
gem "view_component"
gem "pagy", "~> 9.3"

# --- Background jobs -------------------------------------------------------
gem "sidekiq"

# --- Performance / JSON ----------------------------------------------------
gem "oj"
gem "oj_mimic_json", require: false

# --- Active Record helpers ------------------------------------------------
gem "discard", "~> 1.3"
gem "groupdate"
gem "ar_lazy_preload"
gem "logidze"
gem "fx"
gem "state_machines-activerecord"
gem "after_commit_everywhere"

# --- Mail / Notifications --------------------------------------------------
gem "active_delivery"
gem "abstract_notifier"

# --- Ruby toolkit ----------------------------------------------------------
gem "dry-initializer"
gem "dry-monads"
gem "retriable"
gem "nanoid"

# --- Realtime / AnyCable ---------------------------------------------------
gem "anycable-rails"

# --- Security --------------------------------------------------------------
gem "rack-attack"
gem "secure_headers"

# --- Production observability (logging, metrics, dashboards) --------------
group :production do
  gem "lograge"
  gem "yabeda-rails"
  gem "yabeda-sidekiq"
  gem "yabeda-prometheus"
end

gem "pghero"

# =============================================================================
# Development & Test
# =============================================================================
group :development, :test do
  gem "debug", platforms: %i[mri windows], require: "debug/prelude"
  gem "bundler-audit", require: false
  gem "brakeman", require: false

  gem "rspec-rails"
  gem "factory_bot_rails"
  gem "faker"

  # Evil Martians' "RuboCoping with legacy" recipe
  gem "standard", require: false
  gem "rubocop", require: false
  gem "rubocop-rails", require: false
  gem "rubocop-rspec", require: false
  gem "rubocop-performance", require: false
  gem "rubocop-factory_bot", require: false

  # Detects non-atomic database transactions / side-effects
  gem "isolator"
  gem "n_plus_one_control"
end

group :development do
  gem "web-console"
  gem "lefthook", require: false
  gem "evil-seed", require: false
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
end

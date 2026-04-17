require "nanoid"

puts "Seeding skills..."
skills = [
  { name: "Ruby",        category: "language",  level: 5, position: 1 },
  { name: "TypeScript",  category: "language",  level: 4, position: 2 },
  { name: "Go",          category: "language",  level: 3, position: 3 },
  { name: "Rails",       category: "framework", level: 5, position: 4 },
  { name: "Hotwire",     category: "framework", level: 4, position: 5 },
  { name: "ViewComponent", category: "framework", level: 4, position: 6 },
  { name: "PostgreSQL",  category: "database",  level: 4, position: 7 },
  { name: "Redis",       category: "database",  level: 4, position: 8 },
  { name: "Docker",      category: "devops",    level: 4, position: 9 },
  { name: "Kamal",       category: "devops",    level: 3, position: 10 },
  { name: "GitHub Actions", category: "devops", level: 4, position: 11 },
  { name: "RSpec",       category: "tool",      level: 5, position: 12 },
  { name: "FactoryBot",  category: "tool",      level: 5, position: 13 },
  { name: "RuboCop",     category: "tool",      level: 4, position: 14 }
]
skills.each { |attrs| Skill.find_or_create_by!(name: attrs[:name]) { |s| s.assign_attributes(attrs) } }

puts "Seeding projects..."
projects = [
  {
    title:       "Rails Gemfile of Dreams demo",
    description: "The site you are reading. A playground Rails app wired up with the gems from Evil Martians' Gemfile of Dreams: view_component, action_policy, pagy, logidze, anyway_config, rack-attack, lograge, and more.",
    tech_stack:  "Ruby, Rails main, PostgreSQL, Tailwind CSS, Hotwire, ViewComponent",
    url:         "https://yuhi.dev",
    github_url:  "https://github.com/yuhi-sato/rails-main-playground-",
    featured:    true,
    position:    1
  },
  {
    title:       "Ops Dashboard",
    description: "Internal dashboard for shipping Rails apps: PgHero database health, Sidekiq queue visibility, Yabeda/Prometheus metrics, and per-team feature flag controls.",
    tech_stack:  "Rails, Sidekiq, PgHero, Yabeda, Prometheus",
    url:         "",
    github_url:  "",
    featured:    true,
    position:    2
  },
  {
    title:       "Scheduled Reports Engine",
    description: "Groupdate + Active Delivery powered reporting service with background generation via Sidekiq and version history via Logidze.",
    tech_stack:  "Rails, Sidekiq, Groupdate, Active Delivery, Logidze",
    url:         "",
    github_url:  "",
    featured:    false,
    position:    3
  }
]
projects.each { |attrs| Project.find_or_create_by!(title: attrs[:title]) { |p| p.assign_attributes(attrs) } }

puts "Seeding posts..."
posts = [
  {
    slug:         "why-i-use-evil-martians-gemfile",
    title:        "The gems I reach for on every Rails project",
    published_at: 2.weeks.ago,
    tags:         %w[rails gems productivity],
    body: <<~MD
      Over the past few years I have standardized on a stable set of Ruby gems that show up in
      almost every Rails project I touch. Most of them come from Evil Martians' famous
      "Gemfile of Dreams" article — a carefully curated list that keeps saving me time.

      view_component gives me reusable UI pieces that are trivial to test.
      action_policy keeps authorization explicit, testable, and a joy to read.
      anyway_config lets me stop reinventing configuration loaders on each project.
      pagy makes pagination fast and doesn't pull half of ActiveSupport into my views.

      This very site is built with that stack, and the code is open source.
    MD
  },
  {
    slug:         "hotwire-is-the-default",
    title:        "Hotwire is my default for new Rails apps",
    published_at: 1.week.ago,
    tags:         %w[hotwire rails turbo stimulus],
    body: <<~MD
      Hotwire — Turbo plus Stimulus — has become my default front-end for Rails apps.
      The vast majority of what a typical web app needs (navigation, forms, modals, live updates)
      can be delivered with Turbo alone. Reach for React only when the interactivity budget
      actually demands it.
    MD
  },
  {
    slug:         "logidze-audits-without-tears",
    title:        "Audit trails in Rails without tears, using Logidze",
    published_at: 3.days.ago,
    tags:         %w[logidze postgresql audit],
    body: <<~MD
      If you need to know what a record looked like last Tuesday, papertrail used to be the answer.
      Logidze pushes the history into a single JSON column with PostgreSQL triggers — no extra
      tables, no N+1 versions, and no "load all versions into memory" performance traps.
    MD
  }
]
posts.each { |attrs| Post.find_or_create_by!(slug: attrs[:slug]) { |p| p.assign_attributes(attrs) } }

puts "Done."

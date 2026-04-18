# Yuhi's Engineer Site

Rails (main branch, edge) portfolio site for engineer **yuhi**, built as a
working showcase of Evil Martians'
[_Gemfile of Dreams_](https://evilmartians.com/chronicles/gemfile-of-dreams-libraries-we-use-to-build-rails-apps).

Every library from the article is wired into the app — not just listed in the
Gemfile — so the code doubles as a reference for how the pieces fit together
in a real application.

## Stack

- **Rails** `github: "rails/rails", branch: "main"` (currently `8.2.0.alpha`)
- **Ruby** 3.3.6
- **PostgreSQL** (required — the app uses JSONB, tsvector, functions, triggers)
- **Hotwire** (Turbo + Stimulus) + **Tailwind CSS** for the frontend
- **Import Maps** for JavaScript
- **Sidekiq** as the production ActiveJob adapter

## Features

| URL | What it demonstrates |
| --- | --- |
| `/` | Hero, featured projects, recent posts, skills (ViewComponent + anyway_config) |
| `/about` | Bio + skills grouped by category |
| `/projects` `/projects/:id` | Project listing (Discard soft-delete + ActionPolicy scopes) |
| `/posts` `/posts?q=…` | Paginated blog (Pagy) with full-text search (pg_search) |
| `/posts/:slug` | Post detail (Logidze history, state_machines status, store_attribute metadata) |
| `/stats` | Aggregates via `groupdate` + `fx`-managed SQL function |
| `/contact` | Contact form → `ContactSubmission` service (dry-monads + retriable + after_commit_everywhere + Stoplight) |
| `/api/v1/posts(.json)` | Alba-serialized JSON API (respects ActionPolicy scope, supports `?q=`) |
| `/pghero` `/letters` `/lookbook` | Dev-only: PgHero dashboard, letter_opener web, Lookbook previews |

## Gemfile of Dreams — where each gem lives

**Core** `rails` `pg` `puma` `propshaft` `importmap-rails` `turbo-rails` `stimulus-rails` `tailwindcss-rails`

**Background jobs & scheduling** `sidekiq`, `schked` (`config/schedule.rb`)

**Configuration** `anyway_config` → `app/configs/site_config.rb` + `config/site.yml`

**Authorization** `action_policy` → `app/policies/**`, applied in controllers via `authorized_scope` / `authorize!`

**Views** `view_component` + `view_component-contrib` → `app/components/**`, `pagy` on `/posts`

**Active Record extensions**
- `discard` — soft-delete on Post & Project
- `groupdate` — month bucketing on `/stats`
- `ar_lazy_preload` — auto-preload on
- `logidze` — per-row JSONB history on Post
- `fx` — `db/functions/posts_published_count_v01.sql`
- `pg_search` — `Post.search_text`
- `store_attribute` / `store_model` — typed JSONB fields on Post
- `state_machines-activerecord` — Post draft/published/archived
- `after_commit_everywhere` — safe post-commit hooks in `ContactSubmission`
- `active_record-associated_object` + `active_job-performs` — `Post::Publisher`, `Post#publish_later`

**Mail / notifications** `active_delivery` + `abstract_notifier` (ContactDelivery + ContactMailer + ContactNotifier), `premailer-rails`

**Images** `imgproxy` → `ImagesHelper#proxy_image`

**Ruby toolkit** `dry-initializer`, `dry-monads`, `dry-effects` (`AuditTrail`), `retriable`, `nanoid`, `stoplight`, `feature_toggles` (`SiteFeatures`)

**JSON / serialization** `alba` (`app/resources/post_resource.rb`) + `oj` / `oj_mimic_json`

**Security / middleware** `rack-attack`, `secure_headers`, `silencer` (hushes `/up`)

**Realtime** `anycable-rails`

**Observability (production)** `lograge`, `yabeda-rails`, `yabeda-sidekiq`, `yabeda-prometheus`, `pghero`

**Development**
- `prosopite`, `strong_migrations`, `isolator`, `freezolite`
- `letter_opener` + `letter_opener_web` (mounted at `/letters`)
- `lookbook` (mounted at `/lookbook`)
- `rack-mini-profiler`, `lefthook`, `evil-seed`
- `standard`, `rubocop-rails`, `rubocop-rspec`, `rubocop-performance`, `rubocop-factory_bot`
- `bundler-audit`, `brakeman`

**Test**
- `rspec-rails`, `factory_bot_rails`, `faker`
- `capybara`, `selenium-webdriver`
- `n_plus_one_control` (`/posts` has a constant-query assertion)
- `with_model`, `webmock`, `zonebie`, `test-prof`, `fuubar`, `rspec-instafail`

## Getting started

Requires PostgreSQL on `localhost:5432`.

```sh
bundle install
bin/rails db:create db:migrate db:seed
bin/rails server
```

Open <http://localhost:3000>.

### Environment variables

| Variable | Purpose | Default |
| --- | --- | --- |
| `YUHI_DARK_MODE` | Enable the `dark_mode` feature flag | `0` |
| `YUHI_HERO_IMAGE` | Enable the `hero_image` feature flag | `0` |
| `IMGPROXY_URL` | Base URL for imgproxy | `https://imgproxy.yuhi.dev` |
| `IMGPROXY_KEY` / `IMGPROXY_SALT` | imgproxy signing credentials | unset |
| `REDIS_URL` | Redis for Sidekiq | `redis://localhost:6379/0` |

Everything else is configured through `SiteConfig` in `config/site.yml`
(anyway_config).

## Tests

```sh
bundle exec rspec
```

53 examples, covering:

- Models — Post (state machine, scopes, logidze, fx-backed count, pg_search,
  store_attribute metadata), Project, Skill, Contact, SiteFeatures
- Policies — PostPolicy, ProjectPolicy (with ActionPolicy relation scopes)
- Services — ContactSubmission (dry-monads Success/Failure, retriable retry,
  Stoplight circuit breaker)
- Notifiers — ContactNotifier via `AbstractNotifier::Testing::Driver`
- Resources — Alba PostResource
- Components — ProjectCardComponent, SkillBadgeComponent
- Requests — Pages, Posts (+ `n_plus_one_control`), Projects, Contacts,
  Api::V1::Posts

Formatters are Fuubar + RSpec::Instafail; `zonebie` randomizes the timezone on
every run; `webmock` blocks outbound HTTP.

## Layout

```
app/
  components/        # ViewComponent (+ view_component-contrib)
  configs/           # anyway_config classes
  controllers/
    api/v1/          # Alba-backed JSON API
  deliveries/        # active_delivery
  models/
    post/publisher.rb  # active_record-associated_object collaborator
  notifiers/         # abstract_notifier
  policies/          # action_policy
  resources/         # alba
  services/          # dry-monads + retriable + stoplight
config/
  initializers/      # oj, pagy, sidekiq, rack_attack, secure_headers,
                     # stoplight, imgproxy, prosopite, silencer,
                     # strong_migrations, ar_lazy_preload
  schedule.rb        # schked
  site.yml           # anyway_config source
db/
  functions/         # fx-managed SQL functions
  triggers/          # logidze triggers
spec/
  components/previews/  # lookbook previews
```

## Credits

Curated from Evil Martians'
[_Gemfile of dreams: the libraries we use to build Rails apps_](https://evilmartians.com/chronicles/gemfile-of-dreams-libraries-we-use-to-build-rails-apps).

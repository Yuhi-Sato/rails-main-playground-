Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  root "pages#home"
  get  "about",    to: "pages#about",       as: :about
  get  "stats",    to: "pages#stats",       as: :stats

  resources :projects, only: %i[index show]
  resources :posts,    only: %i[index show]

  get  "contact",        to: "contacts#new",    as: :contact_new
  post "contact",        to: "contacts#create", as: :contact
  get  "contact/thanks", to: "contacts#thanks", as: :contact_thanks

  # PgHero dashboard (mount behind auth in production)
  mount PgHero::Engine, at: "pghero" if Rails.env.development?
end

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

  namespace :api do
    namespace :v1 do
      resources :posts, only: %i[index show], param: :id
    end
  end

  # Dev-only mounts
  if Rails.env.development?
    mount PgHero::Engine,        at: "pghero"
    mount LetterOpenerWeb::Engine, at: "letters"
    mount Lookbook::Engine,      at: "lookbook"
  end
end

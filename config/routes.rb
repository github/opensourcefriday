Rails.application.routes.draw do
  devise_for :users,
             skip: %i[registrations passwords],
             controllers: { omniauth_callbacks: "omniauth_callbacks" }
  resources :users, only: [:show]

  root to: "home#index"
  get "/contributors" => redirect("/")

  get "/businesses", to: "home#businesses"
  get "/maintainers", to: "home#maintainers"
  get "/_boomtown", to: "home#boomtown"
end

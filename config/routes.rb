Rails.application.routes.draw do
  devise_for :users, skip: [:registrations], controllers: {omniauth_callbacks: 'omniauth_callbacks'}
  root to: 'home#index'
  get '/businesses', to: 'home#businesses'
  get '/maintainers', to: 'home#maintainers'
end

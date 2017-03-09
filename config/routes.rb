Rails.application.routes.draw do
  devise_for :users, skip: [:registrations], controllers: {omniauth_callbacks: 'omniauth_callbacks'}
  root to: 'home#index'
  get '/contributors', to: 'home#contributors'
  get '/maintainers', to: 'home#maintainers'
end

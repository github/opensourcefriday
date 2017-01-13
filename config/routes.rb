Rails.application.routes.draw do
  devise_for :users, skip: [:registrations], controllers: {omniauth_callbacks: 'omniauth_callbacks'}
  root to: 'home#index'
end

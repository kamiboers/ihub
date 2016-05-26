Rails.application.routes.draw do
  root 'pages#dashboard'

  get '/index', to: 'pages#index', as: 'index'
  get '/dashboard', to: 'pages#dashboard', as: 'dashboard'

  get '/auth/github/callback', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy', as: 'logout'
end

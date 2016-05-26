Rails.application.routes.draw do
  root 'pages#index'
  get '/dashboard', to: 'pages#dashboard', as: 'dashboard'

  get '/auth/github/callback', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy', as: 'logout'
end

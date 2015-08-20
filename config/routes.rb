Rails.application.routes.draw do
  root to: redirect('/bands')

  resources :users, only: [:new, :create, :show]
  resource :session, only: [:new, :create, :destroy]

  resources :bands
  resources :albums
  resources :tracks
end

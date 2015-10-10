Rails.application.routes.draw do
  root to: "users#new"
  resources :users, only: [:show, :new, :create]
  resource :session, only: [:new, :create, :destroy]
  resources :goals
  resources :comments, only: [:create]
end

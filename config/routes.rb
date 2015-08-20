Rails.application.routes.draw do
  root to: redirect('/bands')

  resources :users, only: [:new, :create, :show] do
    get :activate, on: :collection
  end
  
  resource :session, only: [:new, :create, :destroy]

  resources :bands do
    resources :albums, only: [:new]
  end

  resources :albums, except: [:new, :index] do
    resources :tracks, only: [:new]
  end

  resources :tracks, except: [:new, :index]

  resources :notes, only: [:create, :destroy]
end

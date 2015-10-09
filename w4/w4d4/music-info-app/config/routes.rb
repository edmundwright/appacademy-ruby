Rails.application.routes.draw do
  root to: redirect('/bands')

  resources :users, only: [:new, :create, :show, :index] do
    get :activate, on: :collection
    post :make_admin, on: :member
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

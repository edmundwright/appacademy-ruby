Rails.application.routes.draw do
  root to: "static_page#root"
  namespace :api do
    resources :posts,
      default: :json,
      only: [:create, :show, :index, :destroy, :update]
  end
end

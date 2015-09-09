Rails.application.routes.draw do
  root to: "static_page#root"

  resources :posts,
    default: :json,
    only: [:create, :show, :index]
end

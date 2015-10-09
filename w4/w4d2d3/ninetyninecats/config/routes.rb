Rails.application.routes.draw do
  root to: redirect("/cats")

  resource :user, only: [:create, :new]
  resource :session, only: [:create, :new, :destroy]
  resources :cats
  resources :cat_rental_requests do
    post 'approve', on: :member
    post 'deny', on: :member
  end

  #post 'cat_rental_requests/:id/approve' => 'cat_rental_requests#approve', as: "approve"
  #post 'cat_rental_requests/:id/deny' => 'cat_rental_requests#deny', as: "deny"
end

Rails.application.routes.draw do
  resources :cats
  resources :cat_rental_requests do
    post 'approve', on: :member
    post 'deny', on: :member
  end

  resource :user, only: [:create, :new, :show]

  resource :session, only: [:create, :new]

  root to: redirect("/cats")

  #post 'cat_rental_requests/:id/approve' => 'cat_rental_requests#approve', as: "approve"
  #post 'cat_rental_requests/:id/deny' => 'cat_rental_requests#deny', as: "deny"
end

Ninety9cats::Application.routes.draw do
  resources :cats
  resources :cat_rental_requests, only: [:new, :create]
end

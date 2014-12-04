Ninety9cats::Application.routes.draw do
  resources :cats
  resources :cat_rental_requests, only: [:new, :create] do
    member do
      patch 'approve', as: 'approve'
      patch 'deny', as: 'deny'
    end
  end
end

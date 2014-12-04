Ninety9cats::Application.routes.draw do

  root to: 'cats#index'
  resources :cats
  resources :cat_rental_requests, only: [:new, :create] do
    member do
      patch 'approve', as: 'approve'
      patch 'deny', as: 'deny'
    end
  end
end

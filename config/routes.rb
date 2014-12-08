Music::Application.routes.draw do

  root to: 'bands#index'

  resources :users, only: [:new, :create] do
    collection do
      get 'activate'
    end
  end

  resource :session, only: [:new, :create, :destroy]

  resources :bands do
    resources :albums, only: :new
  end

  resources :albums, only: [:create, :edit, :show, :update, :destroy] do
    resources :tracks, only: :new
  end

  resources :tracks, only: [:create, :edit, :show, :update, :destroy]

  resources :notes, only: [:create, :destroy]


end

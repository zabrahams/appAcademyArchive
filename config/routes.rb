Music::Application.routes.draw do

  resource :users, only: [:new, :create, :show]
  resource :session, only: [:new, :create, :destroy]

  resources :bands do
    resource :album, only: :new
  end

  resources :albums, only: [:create, :edit, :show, :update, :destroy] do
    resource :track, only: :new
  end

  resources :tracks, only: [:create, :edit, :show, :update, :destroy]

end

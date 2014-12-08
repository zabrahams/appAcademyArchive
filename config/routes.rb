Music::Application.routes.draw do

  resource :users, only: [:new, :create, :show]
  resource :session, only: [:new, :create, :destroy]

end

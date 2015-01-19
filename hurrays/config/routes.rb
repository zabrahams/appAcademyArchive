Rails.application.routes.draw do
 resources :users, only:[:new, :create, :show]
 resource :session, only:[:new, :create, :destroy]
 resources :goals do
   collection do
     get "completed"
   end
 end
end

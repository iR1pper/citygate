Rails.application.routes.draw do
  root :to => "home#index"
  
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  resources :users, :only => [:show]
    
  namespace "admin", constraints: { format: /(json|html|js| )/ } do
    resources :users
  end
  
end

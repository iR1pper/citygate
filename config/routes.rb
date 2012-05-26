Citygate::Engine.routes.draw do
  root :to => "home#index"
  
  devise_for :users, 
             :controllers => { :omniauth_callbacks => "citygate/users/omniauth_callbacks" }, 
             :class_name => "Citygate::User",
             :module => :devise
  resources :users, :only => [:show]
    
  namespace "admin" do
    resources :users
  end
  
end

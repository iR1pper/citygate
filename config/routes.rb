Citygate::Engine.routes.draw do
  root :to => "home#index"
  
  match "/user/profile" => "users#show", :as => "profile"
  match "/connect/:provider" => "users#connect", :as => "connect"
  
  devise_for :users, 
             :controllers => { 
               :omniauth_callbacks => "citygate/users/omniauth_callbacks"
             }, 
             :class_name => "Citygate::User",
             :module => :devise
    
  namespace "admin", constraints: { format: /(json|html| )/ } do
    resources :users
  end
  
end

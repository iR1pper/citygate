Citygate::Engine.routes.draw do
  root :to => "home#index"
  
  match "/user/profile" => "users#show", :as => "profile"
  
  match '/confirm/:confirmation_token', :to => "devise/confirmations#show", :as => "user_confirm", :only_path => false
  
  devise_for :users, 
             :controllers => { 
               :omniauth_callbacks => "citygate/users/omniauth_callbacks"
             }, 
             :class_name => "Citygate::User",
             :module => :devise
  
  devise_scope :user do
    match '/users/auth/:provider' => 'users/omniauth_callbacks#passthru'
  end

  namespace "admin", constraints: { format: /(json|html| )/ } do
    resources :users
  end
  
end

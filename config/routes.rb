Rails.application.routes.draw do
  root :to => "home#index"
  match 'user_root' => 'home#index'

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  resources :users, :only => [:show]
    
  namespace "admin" do
    resources :users
  end
  
end

Rails.application.routes.draw do
  root :to => "home#index"

  match "/users/:id" => "users#show"
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  
  namespace "admin" do
    resources :users
  end
  
end

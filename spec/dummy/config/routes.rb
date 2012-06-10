Rails.application.routes.draw do
  mount Citygate::Engine => "/"
  
  resources :test, :only => [:index]
end

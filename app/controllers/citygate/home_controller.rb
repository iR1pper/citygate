class Citygate::HomeController < Citygate::ApplicationController
  authorize_resource :class => false
  
  def index
    @users = Citygate::User.all
  end
end

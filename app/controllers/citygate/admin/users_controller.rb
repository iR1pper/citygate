class Citygate::Admin::UsersController < Citygate::Admin::ApplicationController
  load_and_authorize_resource :class => "Citygate::User"
  respond_to :html, :json, :js

  def index
    @users = Citygate::User.paginate(per_page: 15, page: params[:page])
    
    respond_with @users
  end
  
  def show
    @user = Citygate::User.find(params[:id])
    
    respond_with @user
  end
  
end

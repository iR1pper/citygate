class Admin::UsersController < Admin::ApplicationController
  respond_to :html, :json, :js
  
  before_filter :authenticate_user!
  
  def index
    @users = User.paginate(per_page: 1, page: params[:page])
    
    respond_with @users
  end
  
  def show
    @user = User.find(params[:id])
    
    respond_with @user
  end
  
end

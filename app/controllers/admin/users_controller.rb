class Admin::UsersController < Admin::ApplicationController
  before_filter :authenticate_user!
  
  def index
    @users = User.paginate(per_page: 15, page: params[:page])
  end
  
  def show
    @user = User.find(params[:id])
  end
end

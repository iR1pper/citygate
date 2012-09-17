class Citygate::Admin::UsersController < Citygate::Admin::ApplicationController
  load_and_authorize_resource :class => "Citygate::User"
  respond_to :html, :json, :js

  def index
    @users = Citygate::User.paginate({page: params[:page]}.merge(Citygate::Engine.will_paginate_options))

    respond_with @users
  end

  def show
    @user = Citygate::User.find(params[:id])

    respond_with @user
  end

  def edit
    @user = Citygate::User.find(params[:id])

    respond_with @user
  end

  def update
    @user = Citygate::User.find(params[:id])

    if @user.update_without_password(params[:user])
      flash[:notice] = t('admin.users.update.success')
      redirect_to :action => 'show'
    else
      flash[:error] = t('admin.users.update.error')
      redirect_to :action => 'edit'
    end
  end

  def destroy
    @user = Citygate::User.find(params[:id])
    @user.destroy

    redirect_to admin_users_path
  end
end

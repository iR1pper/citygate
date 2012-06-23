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

end

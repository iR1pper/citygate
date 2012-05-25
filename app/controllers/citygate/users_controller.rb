class Citygate::UsersController < ApplicationController
  load_and_authorize_resource :class => "Citygate::User"

  def show
    @user = User.find(params[:id])
  end
end

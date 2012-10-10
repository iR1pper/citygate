class Citygate::UsersController < Citygate::ApplicationController
  load_and_authorize_resource :class => "Citygate::User"

  def show
    authorize! :show, current_user

    @providers = Citygate::User.omniauth_providers
  end
end

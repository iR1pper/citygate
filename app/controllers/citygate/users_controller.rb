class Citygate::UsersController < Citygate::ApplicationController
  load_and_authorize_resource :class => "Citygate::User"

  def show
    @providers = Citygate::User.omniauth_providers
  end
end

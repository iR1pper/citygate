class Citygate::Admin::ApplicationController < ::Admin::ApplicationController
  protect_from_forgery
  layout 'admin/application'

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end
  
  def current_ability
    @current_ability ||= Citygate::Ability.new(current_user)
  end
end

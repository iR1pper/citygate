class Citygate::ApplicationController < ::ApplicationController
  protect_from_forgery
  
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end
  
  def current_ability
    @current_ability ||= Citygate::Ability.new(current_user)
  end
  
  # Devise hack
  def stored_location_for(resource_or_scope)
    root_url
  end
end

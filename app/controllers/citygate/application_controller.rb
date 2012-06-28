# You can change the way CanCan handles an access denied to the user
# by writing a rescue_from method in your application_controller.rb
# @example CanCan::AccessDenied handling
#   rescue_from CanCan::AccessDenied do |exception|
#     redirect_to my_custom_path, :alert => exception.message
#   end
class Citygate::ApplicationController < ::ApplicationController
  protect_from_forgery
  
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end unless ::ApplicationController.rescue_handlers.assoc "CanCan::AccessDenied"
  
  # Gets or creates an Ability instance for usage with CanCan
  def current_ability
    @current_ability ||= Citygate::Ability.new(current_user)
  end
  
  # Change Devise's redirect after sign in url
  # @param [Object] resource_or_scope Not used here
  def stored_location_for(resource_or_scope)
    root_url
  end
  
  # Defines the omniauth prefix so that citygate can be
  # mounted in anywhere
  Devise.omniauth_path_prefix = "#{Citygate::Engine.mount_path}/users/auth".squeeze "/"
end

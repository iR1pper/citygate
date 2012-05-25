module AppControllerHelpers
  module ClassMethods
    
  end
  
  module InstanceMethods
    def self.included(clazz)
      clazz.class_exec do
        rescue_from CanCan::AccessDenied do |exception|
          redirect_to root_url, :alert => exception.message
        end
      end
    end
    
    def current_ability
      @current_ability ||= Citygate::Ability.new(current_user)
    end
  end
end
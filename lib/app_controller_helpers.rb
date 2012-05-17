module AppControllerHelpers
  module ClassMethods
    
  end
  
  module InstanceMethods
    # Devise hack
    def stored_location_for(resource_or_scope)
      root_url
    end

    def after_sign_in_path_for(resource)
      # This should work, but session is lost. See https://github.com/plataformatec/devise/issues/1357
      # return_to = session[:return_to]
      # session[:return_to] = nil
      return_to = request.env['omniauth.origin']
      stored_location_for(resource) || return_to || root_path
    end 
  end
end
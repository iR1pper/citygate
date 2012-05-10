module AppControllerHelpers
  module ClassMethods
    
  end
  
  module InstanceMethods
    # Devise hack
    def stored_location_for(resource_or_scope)
      root_url
    end
  end
end
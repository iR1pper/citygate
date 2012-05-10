module AppControllerHelpers
  module ClassMethods
    def hello
      p "From lib"
    end
  end
  
  module InstanceMethods
    # Devise hack
    def stored_location_for(resource_or_scope)
      root_url
    end
  end
end
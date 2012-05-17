require "citygate/engine"

module Citygate
  require "#{File.join(Citygate.root,'lib/app_controller_helpers')}"
    
  ActiveSupport.on_load(:action_controller) do
    extend AppControllerHelpers::ClassMethods
    include AppControllerHelpers::InstanceMethods
  end
end

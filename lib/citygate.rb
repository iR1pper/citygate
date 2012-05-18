require "citygate/engine"

module Citygate
  Dir["#{Citygate.root}/lib/*.rb"].each {|file| require file}

  ActiveSupport.on_load(:action_controller) do
    extend AppControllerHelpers::ClassMethods
    include AppControllerHelpers::InstanceMethods
  end
end

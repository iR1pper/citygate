require "citygate"
require "rails"


module Citygate
  def self.root
    File.expand_path '../../..', __FILE__
  end
  
  class Engine < ::Rails::Engine
    require "#{File.join(Citygate.root,'lib/app_controller_helpers')}"
    
    #isolate_namespace Citygate
    initializer 'myengine.app_controller' do |app|
      ActiveSupport.on_load(:action_controller) do
        extend AppControllerHelpers::ClassMethods
        include AppControllerHelpers::InstanceMethods
      end
    end
  end
end

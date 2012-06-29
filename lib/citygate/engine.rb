require "rails"

require "rubygems"
require "devise"
require "devise_invitable"
require "devise-encryptable"
require 'omniauth'
require 'omniauth-facebook'
require 'omniauth-openid'
require 'uuidtools'
require 'will_paginate'
require 'cancan'

# Make Devise "see" the changes made in the citygate appilication controller
Devise.parent_controller = "Citygate::ApplicationController"

module Citygate
  def self.root
    File.expand_path '../../..', __FILE__
  end

  class Engine < ::Rails::Engine
    isolate_namespace Citygate
    
    config.i18n.load_path += Dir[Citygate::Engine.root.join('config', 'locales', '**', '*.{rb,yml}')]
    
    # Accepts the same options as will_paginate and uses
    # them in the backend
    mattr_accessor :will_paginate_options
    @@will_paginate_options = {per_page: 1}
    
    # If the mount path of citygate in the app changes,
    # this must change
    mattr_accessor :mount_path
    @@mount_path = ""
    
    # The maximum number of allowed users. 0 is unlimited.
    mattr_accessor :no_of_users
    @@no_of_users = 0
    
    def configure
      yield self
    end
  end
end



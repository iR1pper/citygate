require "citygate"
require "rails"

module Citygate
  def self.root
    File.expand_path '../../..', __FILE__
  end

  class Engine < ::Rails::Engine
  end
end

require "rubygems"
require "devise"
require "devise"
require "devise_invitable"
require 'omniauth'
require 'omniauth-facebook'
require 'omniauth-openid'
require 'uuidtools'

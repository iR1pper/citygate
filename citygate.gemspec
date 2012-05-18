$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "citygate/version"
require 'rbconfig'
HOST_OS ||= RbConfig::CONFIG['host_os']

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "citygate"
  s.version     = Citygate::VERSION
  s.authors     = ["Group Buddies"]
  s.email       = ["zamith@groupbuddies.com"]
  s.summary     = "Simple authentication and user management Engine."
  s.description = "Citygate is an Engine that provides user model with sign up and log in, admin backend for managing users."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  # Dependencies
  s.add_dependency "rails",              "~> 3.2.2"  
  s.add_dependency "haml",               ">= 3.1.4"
  s.add_dependency "devise",             ">= 2.0.4"
  s.add_dependency "devise-encryptable", ">= 0.1.1"
  s.add_dependency "devise_invitable",   ">= 1.0.0"
  s.add_dependency "omniauth",           "~> 1.0.2"
  s.add_dependency "omniauth-facebook",  "~> 1.2.0"
  s.add_dependency "omniauth-openid",    "~> 1.0.1"
  s.add_dependency "uuidtools",          ">= 2.1.2"
  s.add_dependency "will_paginate",      ">= 3.0.3"
  
  s.add_development_dependency     "thin", ">= 1.3.1"  
  s.add_development_dependency     "haml-rails", ">= 0.3.4"
  s.add_development_dependency     "rspec-rails",      ">= 2.8.1"
  s.add_development_dependency     "email_spec",       ">= 1.2.1"
  s.add_development_dependency     "factory_girl",     "2.6.4"
  s.add_development_dependency     "cucumber-rails",   ">= 1.3.0"
  s.add_development_dependency     "capybara",         ">= 1.1.2"
  s.add_development_dependency     "database_cleaner", ">= 0.7.1"
  s.add_development_dependency     "launchy",          ">= 2.0.5"
end

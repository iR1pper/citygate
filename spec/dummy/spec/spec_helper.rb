# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment.rb", __FILE__)
require 'rspec/rails'
require 'email_spec'
require 'rspec/autorun'
require 'factory_girl'
require 'devise/test_helpers'
FactoryGirl.find_definitions

ENGINE_RAILS_ROOT=File.join(File.dirname(__FILE__), '../')

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[File.join(ENGINE_RAILS_ROOT, 'spec/support/**/*.rb')].each {|f| require f }

RACK_ENV = ENV['ENVIRONMENT'] ||= 'test'

RSpec.configure do |config|
  config.include(EmailSpec::Helpers)
  config.include(EmailSpec::Matchers)
  # ## Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr

  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true

  # If true, the base class of anonymous controllers will be inferred
  # automatically. This will be the default behavior in future versions of
  # rspec-rails.
  config.infer_base_class_for_anonymous_controllers = false

end

OmniAuth.config.test_mode = true
OmniAuth.config.add_mock(:facebook, {
  "uid" => "10",
  "credentials" => {
    "token" => "1234567890"
  },
  "extra" => {
    "raw_info" => {
      "email" => "zamith@groupbuddies.com",
      "name" => "zamith",
      "link" => "zamith.github.com"
    }
  },
  "info" => {
    "image" => "/path/to/image"
  }
})

OmniAuth.config.mock_auth[:google] = {
  "uid" => "10",
  "credentials" => {
    "token" => "1234567890"
  },
  "info" => {
    "email" => "zamith@groupbuddies.com",
    "name" => "zamith"
  }
}

load "#{Rails.root}/db/seeds.rb"


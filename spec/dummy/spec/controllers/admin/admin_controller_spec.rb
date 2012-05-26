require 'spec_helper'

describe Citygate::Admin::ApplicationController do
  
  it "should exist" do
    Citygate.const_defined?('Admin').should be_true
    Citygate::Admin.const_defined?('ApplicationController').should be_true
  end
  
end
require 'spec_helper'

describe Admin::ApplicationController do
  
  it "should exist" do
    Module.const_defined?('Admin').should be_true
    Admin.const_defined?('ApplicationController').should be_true
  end
  
end
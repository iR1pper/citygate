require 'spec_helper'

describe Citygate::Permission do
  context "load all permissions" do
    it "should load the guest permissions" do
      Citygate::Permission.load_all.should have_key :guest
    end

    it "should load permissions for all the roles" do
      Citygate::Permission.load_all.size.should eq 3
    end
  end
end
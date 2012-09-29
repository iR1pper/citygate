require 'spec_helper'

describe Citygate do
  context "configuration" do
    it "has a roles attribute accessor" do
      Citygate::Engine.should respond_to :roles
    end

    it "has default values" do
      roles = Citygate::Engine.roles

      roles.should eq [{ name: "member" }, { name: "admin" }]
    end
  end
end

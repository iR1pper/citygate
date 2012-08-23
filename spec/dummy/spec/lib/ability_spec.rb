require 'spec_helper'

describe Ability do
  context "initialization" do
    it "should cache the permissions loaded" do
      Ability.new Citygate::User.new
      Ability.class_variable_get(:@@permissions).should_not be_nil
    end
  end
end

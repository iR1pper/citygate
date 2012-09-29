require 'spec_helper'

describe Ability do
  context "initialization" do
    it "caches the permissions loaded" do
      create_ability_with_roles

      Ability.class_variable_get(:@@permissions).should_not be_nil
    end

    it "creates the roles from configuration" do
      ability = create_ability_with_roles

      ability.should respond_to :member
      ability.should respond_to :admin
      ability.should respond_to :crazy_man
    end

    it "creates a role with empty permissions if the user has provided none" do
      ability = create_ability_with_roles

      crazy_man_permissions = ability.crazy_man

      crazy_man_permissions.should be_empty
    end

    it "only defines the roles once" do
      Ability.class_variable_get(:@@defined_roles).should be_true
    end

    it "gives the correct permissions to a role" do
      ability = create_ability_with_roles

      member_permission = ability.member.first

      member_permission.action.should eq "read"
      member_permission.subject_class.should eq "Citygate::User"
    end

    def create_ability_with_roles
      # To make sure there are no cached values in each run
      Object.send(:remove_const, :Ability)
      load "#{Citygate::Engine.root}/lib/ability.rb"

      roles = [
        { name: "member" }, 
        { name: "admin" },
        { name: "crazy_man" }
      ]
      Citygate::Engine.stub(:roles).and_return(roles)
      Ability.new Citygate::User.new
    end
  end
end

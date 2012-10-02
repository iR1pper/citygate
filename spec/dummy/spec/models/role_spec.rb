require 'spec_helper'

describe Citygate::Role do
  it "returns an array of underscored names of roles" do
    role_names = [
      mock_model(Citygate::Role, name: "member"),
      mock_model(Citygate::Role, name: "admin")
    ]
    Citygate::Role.stub(:select).with(:name).and_return(role_names)

    Citygate::Role.underscored_role_names.should eq ["member", "admin"]
  end
end
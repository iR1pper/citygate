require "spec_helper"

describe "routing" do
  
  context "admin users" do
    before(:each) { @routes = Citygate::Engine.routes }
    
    it "should have a route to list the users in html" do
      { get: admin_users_path }.should route_to({controller: "citygate/admin/users", action: "index"})
    end
    
    it "should have a route to list the users in json" do
      { get: admin_users_path(format: "json") }.should route_to({controller: "citygate/admin/users", action: "index", format: "json"})
    end
    
    it "should not have a route to list the users in xml" do
      { get: admin_users_path(format: "xml") }.should_not be_routable
    end
    
  end
  
end
require "spec_helper"

describe "routing" do
  
  context "admin users" do
    
    it "should have a route to list the users in html and it should be the default" do
      { get: admin_users_path }.should route_to({controller: "admin/users", action: "index", format: "html"})
    end
    
    it "should have a route to list the users in json" do
      { get: admin_users_path(format: "json") }.should route_to({controller: "admin/users", action: "index", format: "json"})
    end
    
    it "should not have a route to list the users in xml" do
      { get: admin_users_path(format: "xml") }.should_not be_routable
    end
    
  end
  
end
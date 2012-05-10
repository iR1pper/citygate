require 'spec_helper'

describe Users::OmniauthCallbacksController do

  context "facebook" do
    before (:each) do
      request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:facebook]
      request.env["devise.mapping"] = Devise.mappings[:user]
    end
    
    it "should create a new user" do
      lambda {
        get :facebook
      }.should change(User,:count).by(1)
    end
    
    it "should create a new authorization" do
      lambda {
        get :facebook
      }.should change(Authorization,:count).by(1)
    end
    
    context "not database" do
      before (:each) do
        get :facebook
      end
      
      it "should create a authorization for facebook provider" do
        assigns(:user).authorizations.last.provider.should == "Facebook"
      end
      
      it "should create a authorization for the right user" do
        assigns(:user).id.should == Authorization.last.user_id
      end    
      
      it "should create a user with the correct email" do
        assigns(:user).email.should == "zamith@groupbuddies.com"
      end
    end
  end
  
  context "google" do
    before (:each) do
      request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:google]
      request.env["devise.mapping"] = Devise.mappings[:user]
    end
    
    it "should create a new user" do
      lambda {
        get :google
      }.should change(User,:count).by(1)
    end
    
    it "should create a new authorization" do
      lambda {
        get :google
      }.should change(Authorization,:count).by(1)
    end
    
    context "not database" do
      before (:each) do
        get :google
      end
      
      it "should create a authorization for google provider" do
        assigns(:user).authorizations.last.provider.should == "Google"
      end
      
      it "should create a authorization for the right user" do
        assigns(:user).id.should == Authorization.last.user_id
      end    
      
      it "should create a user with the correct email" do
        assigns(:user).email.should == "zamith@groupbuddies.com"
      end
    end
  end


end

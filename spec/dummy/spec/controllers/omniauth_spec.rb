require 'spec_helper'

describe Users::OmniauthCallbacksController do

  shared_examples "a provider for" do |provider|
    describe "provider" do
      before (:each) do
        request.env["omniauth.auth"] = OmniAuth.config.mock_auth[provider]
        request.env["devise.mapping"] = Devise.mappings[:user]
      end
      
      it "should create a new user" do
        lambda {
          get provider
        }.should change(User,:count).by(1)
      end
      
      it "should create a new authorization" do
        lambda {
          get provider
        }.should change(Authorization,:count).by(1)
      end
      
      context "not database" do
        before (:each) do
          get provider
        end
        
        it "should create a authorization for #{provider} provider" do
          assigns(:user).authorizations.last.provider.should == provider.to_s.capitalize
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

  context "facebook" do
    it_behaves_like "a provider for", :facebook
  end
  
  context "google" do
    it_behaves_like "a provider for", :google
  end

end

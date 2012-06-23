require 'spec_helper'

describe Citygate::Users::OmniauthCallbacksController do

  shared_examples "a provider for" do |provider|
    describe "provider" do
      before (:each) do
        request.env["omniauth.auth"] = OmniAuth.config.mock_auth[provider]
        request.env["devise.mapping"] = Devise.mappings[:user]
      end
      
      it "should create a new user" do
        expect {
          get provider
        }.to change{Citygate::User.count}.by(1)
      end
      
      it "should create a new authorization" do
        expect {
          get provider
        }.to change{Citygate::Authorization.count}.by(1)
      end
      
      context "limiting users" do
        before (:each) do
          Citygate::Engine.no_of_users = 1
          Factory.create(:user)
          request.env["omniauth.auth"] = OmniAuth.config.mock_auth[provider]
          request.env["devise.mapping"] = Devise.mappings[:user]
        end
        
        it "should not create a new user" do
        expect {
          get provider
        }.not_to change{Citygate::User.count}
      end
      
      it "should not create a new authorization" do
        expect {
          get provider
        }.not_to change{Citygate::Authorization.count}
      end
      end
      
      context "not changing the database" do
        before (:each) do
          get provider
        end
        
        it "should create a authorization for #{provider} provider" do
          assigns(:user).authorizations.last.provider.should == provider.to_s.capitalize
        end
        
        it "should create a authorization for the right user" do
          assigns(:user).id.should == Citygate::Authorization.last.user_id
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

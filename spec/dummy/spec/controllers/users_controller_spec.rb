require 'spec_helper'
include Devise::TestHelpers

describe UsersController do

  before (:each) do
    @user = Factory.create(:user)
    sign_in @user
  end

  describe "GET 'show'" do
    
    it "should be successful" do
      get :show, :id => @user.id
      response.should be_success
    end
    
    it "should find the right user" do
      get :show, :id => @user.id
      assigns(:user).should == @user
    end
    
  end
  
  describe "login omniauth" do
    before (:each) do
      @cb = Users::OmniauthDummy.new
    end
    
    context "facebook" do
      it "should create a new user" do
        lambda {
          @cb.facebook
        }.should change(User,:count).by(1)
      end
      
      it "should create a user with the correct email" do
        @cb.facebook.email.should == "zamith@groupbuddies.com"
      end
      
      it "should create a new authorization" do
        lambda {
          @cb.facebook
        }.should change(Authorization,:count).by(1)
      end
      
      it "should create a authorization for google provider" do
          @cb.facebook.authorizations.last.provider.should == "Facebook"
      end
      
      it "should create a authorization for the right user" do
          user = @cb.facebook
          Authorization.last.user_id.should == user.id
      end
    end
    
    context "google" do
      it "should create a user with the correct email" do
        @cb.google.email.should == "zamith@groupbuddies.com"
      end
      
      it "should create a new user" do
        lambda {
          @cb.google
        }.should change(User,:count).by(1)
      end
      
      it "should create a new authorization" do
        lambda {
          @cb.google
        }.should change(Authorization,:count).by(1)
      end
      
      it "should create a authorization for google provider" do
          @cb.google.authorizations.last.provider.should == "Google"
      end
      
      it "should create a authorization for the right user" do
          user = @cb.google
          Authorization.last.user_id.should == user.id
      end
    end
    
  end

end

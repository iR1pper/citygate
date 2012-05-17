require 'spec_helper'

describe Admin::UsersController do
  
  before (:each) do
    @user = Factory.create(:user)
    sign_in @user
  end
  
  it "should get 15 or less users at a time" do
    get :index
    assigns(:users).size.should be <= 15
  end
  
end
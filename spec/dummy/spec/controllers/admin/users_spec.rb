require 'spec_helper'

describe Citygate::Admin::UsersController do
  
  before (:each) do
    @user = Factory.create(:user)
    sign_in @user
  end
  
  it "should get the defined number of users or less at a time" do
    get :index
    assigns(:users).size.should be <= Citygate::Engine.will_paginate_options[:per_page]
  end
  
end
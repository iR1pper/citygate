require 'spec_helper'

describe Citygate::HomeController do

  describe "GET 'index'" do
    it "should be successful" do
      p Citygate::Engine.routes.named_routes[:root]
      get :index
      response.should be_success
    end
  end

end

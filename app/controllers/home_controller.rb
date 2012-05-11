class HomeController < Citygate::CitygateController
  def index
    @users = User.all
  end
end

class Citygate::HomeController < Citygate::ApplicationController
  authorize_resource :class => false
  skip_authorize_resource :only => :role_change
  
  def index
    @users = Citygate::User.all
  end
  
  def role_change
    saved = current_user.update_attribute :role_id, params[:data]
    
    respond_to do |format|
      format.json { render json: { text: (saved) ? "OK" : "Arrebentou", redirect: root_path } }
    end
  end
end

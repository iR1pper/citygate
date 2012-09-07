module Citygate
  module ApplicationHelper
    
    def role_changer
      if Rails.env == "development" && current_user
        @role = current_user.role || Citygate::Role.new
        render :partial => "citygate/home/role_changer"
      end
    end

    def citygate_nav_links
      render 'citygate/shared/navigation'
    end
    
  end
end

class Citygate::Admin::ApplicationController < Citygate::ApplicationController
  protect_from_forgery
  layout :set_layout

  private
  def set_layout
    if request.headers['X-PJAX-layout']
      "admin/application"
    elsif request.headers['X-PJAX']
      false
    else
      "admin/application"
    end
  end
end

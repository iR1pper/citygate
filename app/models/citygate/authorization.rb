module Citygate
  class Authorization < ActiveRecord::Base
    
    belongs_to :user
    
    attr_accessible :provider, :uid, :user_id, :token, :secret, :name, :link, :image_url
  end
end

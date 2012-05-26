module Citygate
  # @author Zamith
  # Holds the authorizations given by the users to get information 
  # from their facebook and/or google accounts
  class Authorization < ActiveRecord::Base
    
    belongs_to :user
    
    # @!visibility public
    attr_accessible :provider, :uid, :user_id, :token, :secret, :name, :link, :image_url
  end
end

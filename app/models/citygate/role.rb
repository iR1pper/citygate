module Citygate
  # @author Zamith
  class Role < ActiveRecord::Base
    attr_accessible :name
    has_many :permissions
  end
end
module Citygate
  # @author Zamith
  class Role < ActiveRecord::Base
    attr_accessible :name
    has_many :permissions

    def self.underscored_role_names
      self.select(:name).map{|r|r.name.underscore}
    end
  end
end
module Citygate
  # @author Zamith
  class Permission < ActiveRecord::Base
    attr_accessible :action, :subject_class, :subject_id, :role_id
    belongs_to :role

    # Load all the permissions for all the roles
    # DB intensive, should run only once!
    def self.load_all
      permissions = {}

      # Get guest permissions
      permissions[:guest] = Citygate::Permission.find_all_by_role_id(nil)

      # Get everyother role permissions
      roles = Citygate::Role.select [:id, :name]
      roles.each do |role|
        permissions[role.name.underscore.to_sym] = Citygate::Permission.find_all_by_role_id(role.id)
      end

      return permissions
    end
  end
end
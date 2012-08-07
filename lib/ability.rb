# @author Zamith
class Ability
  include CanCan::Ability

  # Defines the permissions for a user wich is not logged in or if it is,
  # calls the corresponding method to its role
  # @param [Citygate::User] user the current user
  def initialize(user)
    @user = user || Citygate::User.new # guest user (not logged in)

    Citygate::Permission.find_all_by_role_id(nil).each do |permission|
      handle_permission permission
    end

    if @user.role
      send(@user.role.name.downcase)
    end
  end

  # Defines the permissions on a user with the role of member
  def member
    Citygate::Permission.find_all_by_role_id(1).each do |permission|
      handle_permission permission
    end
  end

  # Defines the permissions on a user with the role of admin, which inherits from member
  def admin
    member
    Citygate::Permission.find_all_by_role_id(2).each do |permission|
      handle_permission permission
    end
  end

  protected

    def handle_permission(permission)
      if permission.subject_id.nil?
        begin
          can permission.action.to_sym, permission.subject_class.constantize
        rescue
          can permission.action.to_sym, permission.subject_class.to_sym
        end
      else
        begin
          can permission.action.to_sym, permission.subject_class.constantize, :id => permission.subject_id
        rescue
          can permission.action.to_sym, permission.subject_class.to_sym, :id => permission.subject_id
        end
      end
    end

end

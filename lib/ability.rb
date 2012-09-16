# @author Zamith
class Ability
  include CanCan::Ability

  # Defines the permissions for a user wich is not logged in or if it is,
  # calls the corresponding method to its role
  # @param [Citygate::User] user the current user
  def initialize(user)
    # This runs only once
    @@permissions ||= Citygate::Permission.load_all

    @user = user || Citygate::User.new # guest user (not logged in)

    @@permissions[:guest].each do |permission|
      handle_permission permission
    end

    if @user.role
      send(@user.role.name.downcase)
    end
  end

  # Defines the permissions on a user with the role of member
  def member
    @@permissions[:member].each do |permission|
      handle_permission permission
    end
  end

  # Defines the permissions on a user with the role of admin
  # As this is a super admin that can do anything, it does not need
  # to inherit from member
  def admin
    #member
    @@permissions[:admin].each do |permission|
      handle_permission permission
    end
  end

  protected

    def handle_permission(permission)
      if permission.subject_id.nil?
        begin
          can permission.action.to_sym, permission.subject_class.constantize, generate_conditions_hash(permission)
        rescue
          can permission.action.to_sym, permission.subject_class.to_sym, generate_conditions_hash(permission)
        end
      else
        begin
          can permission.action.to_sym, permission.subject_class.constantize, generate_conditions_hash(permission)
        rescue
          can permission.action.to_sym, permission.subject_class.to_sym, generate_conditions_hash(permission)
        end
      end
    end

    def generate_conditions_hash(permission)
      conditions_hash = {}
      if permission.conditions

        permission.conditions.split(",").each do |condition|
          key,value = conditions_hash.split("#")
          conditions_hash[key.to_sym] = instance_eval value
        end
        
        conditions_hash.merge({id: permission.subject_id}) if permission.subject_id
      end
      
      return conditions_hash
    end

end

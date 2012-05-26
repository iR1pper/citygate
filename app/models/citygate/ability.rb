# @author Zamith
module Citygate
  class Ability
    include CanCan::Ability
  
    # Defines the permissions for a user wich is not logged in or if it is, 
    # calls the corresponding method to its role
    # @param [Citygate::User] user the current user
    def initialize(user)
      @user = user || User.new # guest user (not logged in)
      
      can :index, :home
      
      if @user.role
        send(@user.role.name.downcase)
      end
    end
    
    # Defines the permissions on a user with the role of member
    def member
      can :read, Citygate::User
    end
    
    # Defines the permissions on a user with the role of admin, which inherits from member
    def admin
      member
      can :manage, :all
    end
    
  end
end

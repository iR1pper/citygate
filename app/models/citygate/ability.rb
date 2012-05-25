module Citygate
  class Ability
    include CanCan::Ability
  
    def initialize(user)
      @user = user || User.new # guest user (not logged in)
      
      can :index, :home
      
      if @user.role
        send(@user.role.name.downcase)
      end
    end
    
    def member
      can :read, Citygate::User
    end
    
    def admin
      member
      can :manage, :all
    end
    
  end
end

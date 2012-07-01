module Citygate
  
  # @author Zamith
  # @!attribute name
  #   @return [String] the name of the user
  # @!attribute email
  #   @return [String] the email of the user
  class User < ActiveRecord::Base
    include Gravatar

    # @!group Devise configurations
    devise :database_authenticatable, :registerable, :encryptable,
      :recoverable, :rememberable, :trackable, :validatable, :confirmable, :omniauthable

    devise  :encryptor => :sha1
    # @!endgroup

    attr_accessible :name, :email, :password, :password_confirmation, :remember_me, :confirmed_at

    has_many :authorizations, :dependent => :destroy
    belongs_to :role
    
    before_create :check_no_of_users

    # Get the json object for an user. Used by to_json.
    # @example
    #   {
    #     "email": "user@example.com",
    #     "name": "First User",
    #     "link": null,
    #     "image": "https://secure.gravatar.com/avatar/b58996c504c5638798eb6b511e6f49af.png/rating=g"
    #   }
    # @return [Hash] the json object in the form of an hash
    def as_json(options = {})
      authorization = self.authorizations.first
      {
        email: email,
        name: name || (authorization.name if authorization),
        link: (authorization.link if authorization),
        image: (authorization.image_url if authorization) || self.gravatar_url
      }
    end
    
    # Get the name if it is present or else get the email
    # @return [String] the name or email of the user
    def name_or_email
       self.name || self.email
    end
    
    
    protected
    
    def check_no_of_users
      if Citygate::Engine.no_of_users > 0 && Citygate::User.count >= Citygate::Engine.no_of_users
        self.errors.add(:base,I18n::t('users.errors.too_many'))
        return false
      else
        return true
      end
    end
  end
end

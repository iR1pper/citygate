# @author Zamith
module Citygate
  
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

    # Get the json object for an user
    # @example
    #   {
    #     "email": "user@example.com",
    #     "name": "First User",
    #     "link": null,
    #     "image": "https://secure.gravatar.com/avatar/b58996c504c5638798eb6b511e6f49af.png/rating=g"
    #   }
    def as_json(options = {})
      authorization = self.authorizations.first
      {
        email: email,
        name: name || (authorization.name if authorization),
        link: (authorization.link if authorization),
        image: (authorization.image_url if authorization) || self.gravatar_url
      }
    end
  end
end

module Citygate
  class User < ActiveRecord::Base
    include Gravatar

    devise :database_authenticatable, :registerable, :encryptable,
      :recoverable, :rememberable, :trackable, :validatable, :confirmable, :omniauthable

    devise  :encryptor => :sha1

    # Setup accessible (or protected) attributes for your model
    attr_accessible :name, :email, :password, :password_confirmation, :remember_me, :confirmed_at

    has_many :authorizations, :dependent => :destroy
    belongs_to :role

    # Instance methods

    def as_json(options = {})
      authorization = self.authorizations.first
      {
        email: email,
        name: name || authorization.name,
        link: authorization.link,
        image: authorization.image_url || self.gravatar_url
      }
    end
  end
end

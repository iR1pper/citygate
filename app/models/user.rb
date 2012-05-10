class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :encryptable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable, :omniauthable
         
  devise  :encryptor => :sha1

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me, :confirmed_at
  
  
  has_many :authorizations, :dependent => :destroy
end

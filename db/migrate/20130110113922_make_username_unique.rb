class MakeUsernameUnique < ActiveRecord::Migration
  def change
    add_index :citygate_users, :username, unique: true
  end
end

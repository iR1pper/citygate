class AddUsernameToUsers < ActiveRecord::Migration
  def change
    add_column :citygate_users, :username, :string
  end
end

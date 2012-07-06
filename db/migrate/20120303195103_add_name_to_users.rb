class AddNameToUsers < ActiveRecord::Migration
  def change
    add_column :citygate_users, :first_name, :string
    add_column :citygate_users, :last_name, :string
  end
end

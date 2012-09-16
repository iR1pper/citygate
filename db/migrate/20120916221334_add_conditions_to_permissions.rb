class AddConditionsToPermissions < ActiveRecord::Migration
  def change
    add_column :citygate_permissions, :conditions, :string
  end
end

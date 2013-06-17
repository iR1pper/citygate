class AddEmailToAuthorizations < ActiveRecord::Migration
  def change
    add_column :citygate_authorizations, :email, :string
  end
end

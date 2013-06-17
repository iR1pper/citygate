# This migration comes from citygate (originally 20130617110007)
class AddEmailToAuthorizations < ActiveRecord::Migration
  def change
    add_column :citygate_authorizations, :email, :string
  end
end

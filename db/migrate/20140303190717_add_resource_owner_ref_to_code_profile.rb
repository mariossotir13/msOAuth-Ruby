class AddResourceOwnerRefToCodeProfile < ActiveRecord::Migration
  def change
    add_column :authorization_code_profiles, :resource_owner_id, :string, limit: 43, null: false
    add_index :authorization_code_profiles, :resource_owner_id
  end
end

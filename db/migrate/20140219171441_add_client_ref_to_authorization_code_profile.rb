class AddClientRefToAuthorizationCodeProfile < ActiveRecord::Migration
  def change
    add_column :authorization_code_profiles, :client_id, :string, limit: 43, null: false
    add_index :authorization_code_profiles, :client_id
  end
end

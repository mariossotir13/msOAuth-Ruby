class CreateJoinTableAuthorizationCodeProfilesToScopes < ActiveRecord::Migration
  def change
    create_join_table :authorization_code_profiles, :authorization_code_scopes,
                      table_name: :authorization_code_profiles_to_scopes
    rename_column :authorization_code_profiles_to_scopes, 'authorization_code_profile_id', :code_id
    rename_column :authorization_code_profiles_to_scopes, 'authorization_code_scope_id', :scope_id
    add_index :authorization_code_profiles_to_scopes, :code_id
    add_index :authorization_code_profiles_to_scopes, :scope_id
    add_index :authorization_code_profiles_to_scopes, [:code_id, :scope_id],
              unique: true, name: 'index_codes_to_scopes_on_code_id_and_scope_id'
  end
end

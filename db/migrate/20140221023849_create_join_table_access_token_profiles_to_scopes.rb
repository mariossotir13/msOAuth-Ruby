class CreateJoinTableAccessTokenProfilesToScopes < ActiveRecord::Migration
  def change
    create_join_table :access_token_profiles, :authorization_code_scopes,
                      table_name: :access_token_profiles_to_scopes
    rename_column :access_token_profiles_to_scopes, 'access_token_profile_id', :token_id
    rename_column :access_token_profiles_to_scopes, 'authorization_code_scope_id', :scope_id
    add_index :access_token_profiles_to_scopes, :token_id
    add_index :access_token_profiles_to_scopes, :scope_id
    add_index :access_token_profiles_to_scopes, [:token_id, :scope_id],
              unique: true, name: 'index_tokens_to_scopes_on_token_id_and_scope_id'
  end
end

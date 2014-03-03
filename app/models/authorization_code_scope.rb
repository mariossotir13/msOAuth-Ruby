class AuthorizationCodeScope < ActiveRecord::Base
  BASIC = 'basic'
  FULL = 'full'

  has_and_belongs_to_many :authorization_code_profiles,
                          association_foreign_key: 'code_id',
                          foreign_key: 'scope_id',
                          join_table: 'authorization_code_profiles_to_scopes'
  has_and_belongs_to_many :access_token_profiles,
                          association_foreign_key: 'token_id',
                          foreign_key: 'scope_id',
                          join_table: 'access_token_profiles_to_scopes'
end

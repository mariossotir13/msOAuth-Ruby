class AuthorizationCodeProfile < ActiveRecord::Base
  belongs_to :client
  has_one :access_token_profile
  has_and_belongs_to_many :authorization_code_scopes,
                          association_foreign_key: 'scope_id',
                          foreign_key: 'code_id',
                          join_table: 'authorization_code_profiles_to_scopes'
end

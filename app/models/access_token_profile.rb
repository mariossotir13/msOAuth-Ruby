class AccessTokenProfile < ActiveRecord::Base
  belongs_to :authorization_code_profile
  has_and_belongs_to_many :authorization_code_scopes,
                          association_foreign_key: 'scope_id',
                          foreign_key: 'token_id',
                          join_table: 'access_token_profiles_to_scopes'
end

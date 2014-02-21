class AddAuthCodeRefToTokenProfile < ActiveRecord::Migration
  def change
    add_reference :access_token_profiles, :authorization_code_profile, index: true, null: false
  end
end

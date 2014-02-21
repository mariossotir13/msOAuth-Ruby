class CreateAccessTokenProfiles < ActiveRecord::Migration
  def change
    create_table :access_token_profiles do |t|
      t.string :access_token, limit: 128, null: false
      t.string :access_token_type, null: false
      t.datetime :expiration_date, null: false
      t.string :grant_type, limit: 255, null: false
    end
  end
end

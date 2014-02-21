class CreateAuthorizationCodeProfiles < ActiveRecord::Migration
  def change
    create_table :authorization_code_profiles do |t|
      t.string :authorization_code, limit: 128, null: false
      t.datetime :expiration_date, null: false
      t.text :redirection_uri, null: false
      t.string :response_type, null: false
      t.text :state, null: false
    end
  end
end

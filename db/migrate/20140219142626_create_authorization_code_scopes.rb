class CreateAuthorizationCodeScopes < ActiveRecord::Migration
  def change
    create_table :authorization_code_scopes do |t|
      t.string :title, limit: 64, null: false
      t.text :description, null: false
    end
  end
end

class CreateClients < ActiveRecord::Migration
  def change
    add_column :users, :app_title, :string, limit: 120
    add_column :users, :redirection_uri, :string
    add_column :users, :client_type, :integer, limit: 2

    add_index :users, :redirection_uri, unique: true
  end
end

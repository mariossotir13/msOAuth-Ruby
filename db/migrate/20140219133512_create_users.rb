class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email, { null: false }
    end

    reversible do |dir|
      dir.up do
        change_column :users, :id, :string, { limit: 43 }
      end
      dir.down do
        change_column :users, :id, :integer
      end
    end
  end
end

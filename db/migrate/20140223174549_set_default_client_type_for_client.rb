class SetDefaultClientTypeForClient < ActiveRecord::Migration
  def change
    change_column_default :users, :client_type, 1
  end
end

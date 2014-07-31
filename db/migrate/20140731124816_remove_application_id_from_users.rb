class RemoveApplicationIdFromUsers < ActiveRecord::Migration
  def up
    remove_column :users, :application_id, :integer
  end

  def down
    add_column :users, :application_id, :integer
    add_index :users, :application_id, name: "user_application_id_ix"
  end
end

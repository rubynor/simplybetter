class CreateApplicationsUsers < ActiveRecord::Migration
  def change
    create_table :applications_users, id: false do |t|
      t.integer :user_id
      t.integer :application_id
    end
    add_index :applications_users, [:application_id, :user_id]
    add_index :applications_users, :user_id
  end
end

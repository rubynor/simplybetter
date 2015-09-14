class AddDisabledToApplications < ActiveRecord::Migration
  def change
    add_column :applications, :disabled, :boolean, default: false, null: false
    add_index :applications, :disabled
  end
end

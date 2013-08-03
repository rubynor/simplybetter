class CreateApplications < ActiveRecord::Migration
  def change
    create_table :applications do |t|
      t.string :name
      t.string :token
      t.integer :customer_id

      t.timestamps
    end
  end
end

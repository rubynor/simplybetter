class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.string :subject_type
      t.integer :subject_id
      t.string :action_type
      t.integer :action_id
      t.string :recipient_type
      t.integer :recipient_id
      t.boolean :checked

      t.timestamps
    end
  end
end

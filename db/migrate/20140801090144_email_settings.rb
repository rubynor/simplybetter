class EmailSettings < ActiveRecord::Migration
  def change
    create_table :email_settings do |t|
      t.references :mailable, polymorphic: true, index: true
      t.boolean :unsubscribed, default: false, null: false

      t.timestamps
    end
  end
end

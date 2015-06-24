class CreateSupportMessages < ActiveRecord::Migration
  def change
    create_table :support_messages do |t|
      t.string :from
      t.string :to
      t.integer :user_id
      t.integer :user_type
      t.integer :application_id
      t.timestamp :sent_at
      t.text :message

      t.timestamps
    end
  end
end

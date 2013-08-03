class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :body
      t.string :user_id
      t.integer :feature_id
      t.integer :votes_count, default: 0

      t.timestamps
    end
  end
end

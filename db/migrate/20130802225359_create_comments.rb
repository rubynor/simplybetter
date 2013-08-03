class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :body
      t.integer :feature_id
      t.integer :creator_id
      t.string  :creator_type
      t.integer :votes_count, default: 0
      t.timestamps
    end
  end
end

class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :body
      t.integer :feature_id
      t.integer :creator_id
      t.string  :creator_type
      t.timestamps
    end
  end
end

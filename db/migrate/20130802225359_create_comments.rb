class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :body
      t.string :user_id
      t.integer :feature_id

      t.timestamps
    end
  end
end

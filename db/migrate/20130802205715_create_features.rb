class CreateFeatures < ActiveRecord::Migration
  def change
    create_table :features do |t|
      t.string :title
      t.text :description
      t.integer :creator_id, :customer_id

      t.timestamps
    end
  end
end

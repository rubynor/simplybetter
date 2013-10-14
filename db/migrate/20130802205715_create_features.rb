class CreateFeatures < ActiveRecord::Migration
  def change
    create_table :features do |t|
      t.string :title
      t.text :description
      t.integer  :application_id
      t.integer :creator_id
      t.string  :creator_type
      t.integer :votes_count, default: 0

      t.timestamps
    end
  end

end

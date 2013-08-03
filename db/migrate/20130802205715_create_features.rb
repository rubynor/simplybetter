class CreateFeatures < ActiveRecord::Migration
  def change
    create_table :features do |t|
      t.string :title
      t.text :description
      t.string :creator_id, :application_id

      t.integer :votes_count, default: 0

      t.timestamps
    end
  end

end

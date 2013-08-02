class CreateFeatures < ActiveRecord::Migration
  def change
    create_table :features do |t|
      t.string :title
      t.text :description
      t.integer :crator_id

      t.timestamps
    end
  end
end

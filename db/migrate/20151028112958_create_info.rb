class CreateInfo < ActiveRecord::Migration
  def change
    create_table :infos do |t|
      t.text :body
      t.string :route
      t.boolean :external, default: false

      t.timestamps
    end
  end
end

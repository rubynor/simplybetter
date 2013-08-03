class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :name
      t.belongs_to :application
      t.timestamps
    end
  end
end

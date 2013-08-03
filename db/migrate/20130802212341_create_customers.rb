class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.string :name
      t.string :token
      t.string :email
      t.string :password_digest

      t.timestamps
    end
  end
end

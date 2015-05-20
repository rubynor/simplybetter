class AddIndexToUserAndCustomer < ActiveRecord::Migration
  def change
    add_index :customers, :email, unique: true
    add_index :users, :email, unique: true
  end
end

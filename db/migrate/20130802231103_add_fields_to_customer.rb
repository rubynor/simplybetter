class AddFieldsToCustomer < ActiveRecord::Migration
  def change
    add_column :customers, :email, :string
    add_column :customers, :password_digest, :string
  end
end

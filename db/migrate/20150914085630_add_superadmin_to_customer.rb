class AddSuperadminToCustomer < ActiveRecord::Migration
  def change
    add_column :customers, :superadmin, :boolean, default: false
  end
end

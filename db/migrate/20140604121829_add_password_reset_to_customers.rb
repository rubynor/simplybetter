class AddPasswordResetToCustomers < ActiveRecord::Migration
  def change
    add_column :customers, :password_reset_token, :string
    add_column :customers, :password_reset_sent_at, :datetime
  end
end

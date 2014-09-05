class AddPromotionCodeToCustomer < ActiveRecord::Migration
  def change
    add_column :customers, :promotion_code, :string
  end
end

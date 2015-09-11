class AddPriceplanToApplication < ActiveRecord::Migration
  def change
    add_column :applications, :price_plan_id, :integer, default: 1
  end
end

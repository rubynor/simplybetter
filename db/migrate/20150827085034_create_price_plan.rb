class CreatePricePlan < ActiveRecord::Migration
  def change
    create_table :price_plans do |t|
      t.string :name
      t.float :price
      t.integer :max_users
    end

    PricePlan.create!(name: 'mini', price: 9.91, max_users: 500)
    PricePlan.create!(name: 'standard', price: 49, max_users: 1000)
    PricePlan.create!(name: 'plus', price: 149, max_users: 3000)
  end
end

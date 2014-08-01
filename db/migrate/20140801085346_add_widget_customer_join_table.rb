class AddWidgetCustomerJoinTable < ActiveRecord::Migration
  def change
    create_table :widget_customers, id: false do |t|
      t.integer :customer_id
      t.integer :application_id
    end
    add_index :widget_customers, [:application_id, :customer_id]
    add_index :widget_customers, :customer_id
  end
end

class CreateApplicationsCustomersJoinTable < ActiveRecord::Migration
  def change
    create_table :applications_customers, id: false do |t|
      t.integer :customer_id
      t.integer :application_id
    end
  end
end

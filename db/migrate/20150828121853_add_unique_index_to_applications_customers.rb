class AddUniqueIndexToApplicationsCustomers < ActiveRecord::Migration
  def change
    remove_index 'applications_customers', name: 'index_applications_customers_on_application_id_and_customer_id'
    add_index 'applications_customers', [:application_id, :customer_id], name: 'index_applications_customers_on_application_id_and_customer_id', using: :btree, unique: true
  end
end

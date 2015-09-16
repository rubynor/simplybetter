class PopulateCustomerIdFieldsOnApplications < ActiveRecord::Migration
  def up
    Application.all.each do |application|
      unless application.owner.present?
        application.owner = application.customers.first if application.customers.any?
        application.save!
      end
    end
  end

  def down
  end
end

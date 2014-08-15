class AddApplicationIdToAbuseReport < ActiveRecord::Migration
  def change
    add_column :abuse_reports, :application_id, :integer
  end
end

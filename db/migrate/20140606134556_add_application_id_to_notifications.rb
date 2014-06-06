class AddApplicationIdToNotifications < ActiveRecord::Migration
  def change
    add_column :notifications, :application_id, :integer
  end
end

class AddIndexesToApplicationAndNotifications < ActiveRecord::Migration
  def change
    add_index :applications, :token, unique: true
    add_index :notifications, [:recipient_id, :application_id, :checked], order: { updated_at: :desc }, name: 'notifications_count_index'
  end
end

class AddActionAttributeToNotification < ActiveRecord::Migration
  def change
    add_column :notifications, :action_attribute, :string
    add_column :notifications, :action_attribute_changed_by_type, :string
    add_column :notifications, :action_attribute_changed_by_id, :integer
  end
end

class AddEnableSupportToApplications < ActiveRecord::Migration
  def change
    add_column :applications, :support_enabled, :boolean, default: true, null: false
    add_column :applications, :support_email, :string, allow_blank: false
  end
end

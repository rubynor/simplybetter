class RenameApplicationsUsersToWidgetUsers < ActiveRecord::Migration
  def change
    rename_table :applications_users, :widget_users
  end
end

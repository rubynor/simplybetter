class SetSupportDefaultToFalse < ActiveRecord::Migration
  def change
    change_column_default :applications, :support_enabled, false
  end
end

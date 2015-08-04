class AddThirdPartySupportToApplications < ActiveRecord::Migration
  def change
    add_column :applications, :third_party_support, :boolean, default: false, null: false
  end
end

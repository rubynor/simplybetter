class AddIconToApplication < ActiveRecord::Migration
  def change
    add_column :applications, :icon, :string
  end
end

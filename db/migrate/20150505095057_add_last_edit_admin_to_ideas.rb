class AddLastEditAdminToIdeas < ActiveRecord::Migration
  def change
    add_column :ideas, :last_edit_admin_id, :integer
    add_column :ideas, :last_edit_admin_time, :datetime
  end
end

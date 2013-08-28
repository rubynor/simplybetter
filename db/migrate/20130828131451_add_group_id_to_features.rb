class AddGroupIdToFeatures < ActiveRecord::Migration
  def change
    add_column :features, :group_id, :integer
  end
end

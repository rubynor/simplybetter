class RenameFeatureGroups < ActiveRecord::Migration
  def up
    rename_table :feature_groups, :idea_groups
  end

  def down
    rename_table :idea_groups, :feature_groups
  end
end

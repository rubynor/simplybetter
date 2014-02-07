class RenameColumns < ActiveRecord::Migration
  def up
    rename_column :comments, :feature_id, :idea_id
    rename_column :ideas, :feature_group_id, :idea_group_id
  end

  def down
    rename_column :comments, :idea_id, :feature_id
    rename_column :ideas, :idea_group_id, :feature_group_id
  end
end

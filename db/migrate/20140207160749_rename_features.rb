class RenameFeatures < ActiveRecord::Migration
  def up
    rename_table :features, :ideas
  end

  def down
    rename_table :ideas, :features
  end
end

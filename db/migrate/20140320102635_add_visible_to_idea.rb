class AddVisibleToIdea < ActiveRecord::Migration
  def change
    add_column :ideas, :visible, :boolean, default: true
  end
end

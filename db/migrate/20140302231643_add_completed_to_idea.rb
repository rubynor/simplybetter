class AddCompletedToIdea < ActiveRecord::Migration
  def change
    add_column :ideas, :completed, :boolean, default: false
  end
end

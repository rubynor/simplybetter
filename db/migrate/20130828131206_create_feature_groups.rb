class CreateFeatureGroups < ActiveRecord::Migration
  def change
    create_table :feature_groups do |t|
      t.integer :application_id
    end
  end
end

class CreateIdeaSubscriptions < ActiveRecord::Migration
  def change
    create_table :idea_subscriptions do |t|
      t.integer :idea_id
      t.string :subscriber_type
      t.integer :subscriber_id
      t.string :subscriber_from_type
      t.integer :subscriber_from_id

      t.timestamps
    end
  end
end

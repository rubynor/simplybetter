class AddIndexes < ActiveRecord::Migration
  def change
    # Foreign keys
    add_index :comments, :idea_id, name: 'comments_idea_id_ix'
    add_index :ideas, :application_id, name: 'ideas_application_id_ix'
    add_index :idea_subscriptions, :idea_id, name: 'idea_subscriptions_idea_id_ix'
    add_index :notifications, :application_id, name: 'notification_application_id_ix'
    add_index :users, :application_id, name: 'user_application_id_ix'
    add_index :applications_customers, [:application_id, :customer_id]
    add_index :applications_customers, :customer_id

    # Polymorphic associations
    add_index :comments, [:creator_id, :creator_type]
    add_index :ideas, [:creator_id, :creator_type]
    add_index :idea_subscriptions, [:subscriber_id, :subscriber_type]
    add_index :idea_subscriptions, [:subscriber_from_id, :subscriber_from_type], name: 'idea_subscriptions_from_poly_ix'
    add_index :notifications, [:subject_id, :subject_type]
    add_index :notifications, [:action_id, :action_type]
    add_index :notifications, [:recipient_id, :recipient_type]
    add_index :notifications, [:action_attribute_changed_by_id, :action_attribute_changed_by_type], name: 'notifications_action_attribute_poly_ix'
    add_index :votes, [:vote_receiver_id, :vote_receiver_type]
    add_index :votes, [:voter_id, :voter_type]
  end
end

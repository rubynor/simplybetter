class IdeaSubscription < ActiveRecord::Base
  belongs_to :idea, inverse_of: :subscriptions
  belongs_to :subscriber, polymorphic: true
  belongs_to :subscriber_from, polymorphic: true
end

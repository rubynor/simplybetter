class IdeaSubscription < ActiveRecord::Base
  belongs_to :idea, inverse_of: :idea_subscriptions
  belongs_to :subscriber, polymorphic: true
  belongs_to :subscriber_from, polymorphic: true

  validates :idea, presence: true
  validates :subscriber, presence: true
  validates :subscriber_from, presence: true

  def self.add(from, subscriber, idea)
    if from.blank?
      raise "'from' argument is nil"
    end
    if subscriber.blank?
      raise "'Subscriber' argument is nil"
    end
    if idea.blank?
      raise "'Idea' argument is nil"
    end

    subscription = where(subscriber_from: from, subscriber: subscriber, idea: idea).first

    if subscription.blank?
      if create(subscriber_from: from, subscriber: subscriber, idea: idea)
        return "created"
      end
      return false
    else
      return "exists"
    end
  end
end

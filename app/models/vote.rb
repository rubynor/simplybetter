class Vote < ActiveRecord::Base
  has_paper_trail
  belongs_to :vote_receiver, polymorphic: true
  belongs_to :voter, polymorphic: true
  has_one :idea_subscription, as: :subscriber_from, dependent: :destroy
  after_save :update_parent_votes_count

  validates_presence_of :vote_receiver, :voter, :value

  include VoteNotificationHelpers

  def cast_vote(value, app_id)
    update!(value: set_vote_value(value))
    subscribe
    notify(app_id)
  end

  private

  def subscribe
    if legit_vote? && vote_receiver.is_a?(Idea)
      IdeaSubscription.add(self, self.voter, self.vote_receiver)
    end
  end

  def legit_vote?
    value > 0 || value < 0
  end

  def update_parent_votes_count
    vote_receiver.update_votes_count
  end

  def set_vote_value(value)
    return if value.nil? || value.zero?
    # The value input could be <1 or >-1
    # so we just need to convert them to
    # correct value..
    value = value >= 1 ? 1 : -1
    # If voter clicks on upvote again, then the
    # vote is canceled
    self.value == value ? 0 : value
  end

end

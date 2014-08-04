class Vote < ActiveRecord::Base
  has_paper_trail
  belongs_to :vote_receiver, polymorphic: true
  belongs_to :voter, polymorphic: true
  has_one :idea_subscription, as: :subscriber_from, dependent: :destroy
  after_save :update_parent_votes_count

  include VoteNotificationHelpers

  def cast_vote(value, app_id)
    return if value == 0
    vote_val = value > 1 ? 1 : -1
    cast(vote_val)
    Thread.new do
      subscribe
      notify(app_id)
      ActiveRecord::Base.connection.close
    end
  end

  def cast(value)
    return if value == 0
    self.value = self.value == value ? 0 : value
    self.save!
  end

  def subscribe
    if legit_vote? && vote_receiver.is_a?(Idea)
      IdeaSubscription.add(self, self.voter, self.vote_receiver)
    end
  end

  protected

  def legit_vote?
    self.value > 0 || self.value < 0
  end

  def update_parent_votes_count
    vote_receiver.update_votes_count
  end

end

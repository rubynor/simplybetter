class Vote < ActiveRecord::Base
  has_paper_trail
  belongs_to :vote_receiver, polymorphic: true
  belongs_to :voter, polymorphic: true
  has_one :idea_subscription, as: :subscriber_from, dependent: :destroy
  after_save :update_parent_votes_count

  include VoteNotificationHelpers

  def cast(value)
    if self.value == 1 && value == 1
      self.value = 0
    elsif self.value == -1 && value == -1
      self.value = 0
    elsif value == 0
      return
    else
      self.value = 0
      self.value += value
    end
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

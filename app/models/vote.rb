class Vote < ActiveRecord::Base
  has_paper_trail
  belongs_to :vote_receiver, polymorphic: true
  belongs_to :voter, polymorphic: true
  has_one :idea_subscriptions, as: :subscriber_from, dependent: :destroy
  after_save :update_parent_votes_count

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
    if legit_vote?
      IdeaSubscription.add(self, self.voter, self.vote_receiver)
    end
  end

  def notify
    if legit_vote?
      Notification.notify(self, self.vote_receiver)
    end
  end

  def notification_text(recipient)
    if vote_receiver.mine?(recipient)
      [
        {bold: "#{voter.name} "},
        {normal: "#{past_tence} on your idea: "},
        {bold: "“#{vote_receiver.title}”"}
      ]
    else
      [
        {bold: "#{voter.name} "},
        {normal: "#{past_tence}: "},
        {bold: "“#{vote_receiver.title}”"}
      ]
    end
  end

  def creator
    self.voter
  end

  protected

  def past_tence
    if self.value > 0
      "upvoted"
    elsif self.value < 0
      "downvoted"
    else
      "blank voted"
    end
  end

  def legit_vote?
    self.value > 0 || self.value < 0
  end

  def update_parent_votes_count
    vote_receiver.update_votes_count
  end

end

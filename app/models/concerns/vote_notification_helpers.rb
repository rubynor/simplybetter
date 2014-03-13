module VoteNotificationHelpers
  def notify
    if legit_vote?
      Notification.notify_group([self.vote_receiver.creator],self, self.vote_receiver)
    end
  end

  def notification_text(recipient, action_attribute = nil, action_attribute_changed_by = nil)
    if vote_receiver.mine?(recipient)
      [
        {bold: "#{voter.name} "},
        {normal: "#{past_tence} your idea: "},
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

  def past_tence
    if self.value > 0
      "upvoted"
    elsif self.value < 0
      "downvoted"
    else
      "blank voted"
    end
  end
end

module VoteNotificationHelpers
  def notify(app_id)
    if legit_vote?
      Notification.notify_group(group: [self.vote_receiver.creator], action: self, subject: self.vote_receiver, app_id: app_id)
    end
  end

  def notification_text(recipient, **args)
    txt = if vote_receiver.mine?(recipient)
            "#{past_tence} your idea: "
          else
            "#{past_tence}: "
          end
    [ { bold: "#{voter.name} " },
      { normal: txt },
      { bold: "“#{vote_receiver.title}”" } ]
  end

  def creator
    self.voter
  end

  def past_tence
    return 'blank voted' if self.value == 0
    self.value > 0 ? 'upvoted' : 'downvoted'
  end
end

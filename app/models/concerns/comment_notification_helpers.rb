module CommentNotificationHelpers
  def notify
    Notification.notify(self, self.idea)
  end

  def notification_text(recipient, action_attribute = nil, action_attribute_changed_by = nil)
    if idea.mine?(recipient)
      [
        {bold: "#{creator.name} "},
        {normal: "wrote a comment on your idea: "},
        {bold: "“#{idea.title}”"}
      ]
    else
      [
        {bold: "#{creator.name} "},
        {normal: "wrote a comment on: "},
        {bold: "“#{idea.title}”"}
      ]
    end
  end
end

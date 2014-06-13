module CommentNotificationHelpers
  def notify
    Notification.notify(action: self, subject: self.idea, app_id: self.idea.application.id)
  end

  def notification_text(recipient)
    txt = if idea.mine?(recipient)
            'wrote a comment on your idea: '
          else
            'wrote a comment on: '
          end
    [
      { bold: "#{creator.name} " },
      { normal: txt },
      { bold: "“#{idea.title}”" }
    ]
  end
end

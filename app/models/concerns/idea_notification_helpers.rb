module IdeaNotificationHelpers
  def notify_customers
    Notification.notify_group(group: self.application.customers, action: self, subject: self, app_id: self.application.id)
  end

  def notify(**args)
    Notification.notify(action: self, subject: self, app_id: self.application.id, action_attr: args[:action_attr], action_attr_changer: args[:action_attr_changer])
  end

  def notification_text(recipient, **args)
    if args[:action_attr].present? && args[:action_attr_changer].present?
      changed_text(recipient, args[:action_attr], args[:action_attr_changer])
    else
      added_text
    end
  end

  private

  def changed_text(recipient, attribute, changer_user)
      txt = mine?(recipient) ? 'changed the status of your idea: ' : 'changed the status of: '
      [
        { bold: "#{changer_user.name} " },
        { normal: txt },
        { bold: "“#{title}” " },
        { normal: "to " },
        { bold: attribute }
      ]
  end

  def added_text
    [
        { bold: "#{creator.name} " },
        { normal: 'added an idea: ' },
        { bold: "“#{title}”" }
    ]
  end
end

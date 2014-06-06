module IdeaNotificationHelpers
  def notify_customers
    Notification.notify_group(self.application.customers, self, self)
  end

  def notify(action_attribute = nil, action_attribute_changed_by = nil)
    Notification.notify(self, self, self.application.id, action_attribute, action_attribute_changed_by)
  end

  def notification_text(recipient, action_attribute = nil, action_attribute_changed_by = nil)
    if (action_attribute.present? && action_attribute_changed_by.present?)
      notification_text_from_changed_attribute(
        recipient, 
        action_attribute, 
        action_attribute_changed_by
      )
    else
      [
        {bold: "#{creator.name} "},
        {normal: "added an idea: "},
        {bold: "“#{title}”"}
      ]
    end
  end

  def notification_text_from_changed_attribute(recipient, attribute, changer_user)
    if mine?(recipient)
      [
        {bold: "#{changer_user.name} "},
        {normal: "changed the status of your idea: "},
        {bold: "“#{title}” "},
        {normal: "to "},
        {bold: attribute}
      ]
    else
      [
        {bold: "#{changer_user.name} "},
        {normal: "changed the status of: "},
        {bold: "“#{title}” "},
        {normal: "to "},
        {bold: attribute}
      ]
    end
  end
end

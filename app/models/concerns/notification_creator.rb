class NotificationCreator
  attr_accessor(
    :action, 
    :subject,
    :app_id,
    :action_attribute, 
    :action_attribute_changer
  )

  def initialize(action, subject, app_id, action_attr = nil, action_attr_changer = nil)
    self.action = action
    self.subject = subject
    self.app_id = app_id
    self.action_attribute = action_attr
    self.action_attribute_changer = action_attr_changer
  end

  def notify_group(user_collection)
    user_collection.each do |u|
      create_notification(u)
    end
  end

  private

  def create_notification(recipient)      
    if type == :attribute
      create_attribute_notification(recipient)
    else
      create_normal_notification(recipient)
    end
  end

  def create_normal_notification(recipient)
    unless action.creator == recipient
      Notification.create_with(action, subject, recipient, app_id)
    end
  end

  def create_attribute_notification(recipient)
    unless action_attribute_changer == recipient
      Notification.create_with(
        action,
        subject,
        recipient,
        app_id,
        action_attribute,
        action_attribute_changer
      )
    end
  end

  def type
    if action_attribute.present? && action_attribute_changer.present?
      :attribute
    else
      :normal
    end
  end

  def assign_attribute_params(attribute, attribute_changer)
    self.action_attribute = attribute
    self.action_attribute_changer = attribute_changer
    self.type = :attribute
  end
end

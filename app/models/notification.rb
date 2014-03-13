class Notification < ActiveRecord::Base
  belongs_to :subject, polymorphic: true
  belongs_to :action, polymorphic: true
  belongs_to :recipient, polymorphic: true
  belongs_to :action_attribute_changed_by, polymorphic: true

  validate :subject, presence: true
  validate :action, presence: true
  validate :recipient, presence: true

  def self.notify(action, subject, action_attribute = nil, action_attribute_changed_by = nil)
    notify_group(subject.subscribers, action, subject, action_attribute, action_attribute_changed_by)
  end

  def self.notify_group(
      group,
      action,
      subject,
      action_attribute = nil,
      action_attribute_changed_by = nil
    )

    group.each do |u|
      if should_get_notification(action,u,action_attribute_changed_by)
        notification = new(
          action: action,
          subject: subject,
          recipient: u,
          action_attribute: action_attribute
        )
        if action_attribute_changed_by.present?
          notification.action_attribute_changed_by = action_attribute_changed_by
        end
        notification.save!
      end
    end
  end

  def self.should_get_notification(action,group_user,action_attribute_changed_by)
    if action_attribute_changed_by.present?
      group_user != action_attribute_changed_by
    else
      action.creator != group_user
    end
  end

  def idea
    subject.id
  end

  def comment
    if action.is_a?(Comment)
      action.id
    end
  end

  def self.for(recipient)
    all.where(recipient: recipient).order('notifications.updated_at DESC')
  end

  def action_user_image
    self.action.creator.gravatar_url
  end

  def text
    self.action.notification_text(recipient, action_attribute, action_attribute_changed_by)
  end

  def time
    self.created_at
  end
end

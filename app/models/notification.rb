class Notification < ActiveRecord::Base
  belongs_to :subject, polymorphic: true
  belongs_to :action, polymorphic: true
  belongs_to :recipient, polymorphic: true
  belongs_to :action_attribute_changed_by, polymorphic: true

  validate :subject_id, presence: true
  validate :action_id, presence: true
  validate :recipient_id, presence: true

  def self.create_with(action,subject,recipient,action_attribute = nil,action_attribute_changed_by = nil)
    notification_attributes = {
      action: action,
      subject: subject,
      recipient: recipient,
      action_attribute: action_attribute,
      action_attribute_changed_by: action_attribute_changed_by
    }.delete_if { |k,v| v.blank? && k.to_s =~ /^action_attribute/ }
    unless where(notification_attributes).first
      new(notification_attributes).save!
    end
  end

  def self.notify(action, subject, action_attribute = nil, action_attribute_changed_by = nil)
    NotificationCreator.new(
      action,
      subject,
      action_attribute,
      action_attribute_changed_by
    ).notify_group(subject.subscribers)
  end

  def self.notify_group(group,action,subject,action_attribute = nil,action_attribute_changed_by = nil)
    NotificationCreator.new(
      action,
      subject,
      action_attribute,
      action_attribute_changed_by
    ).notify_group(group)
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

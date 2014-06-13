class Notification < ActiveRecord::Base
  belongs_to :subject, polymorphic: true
  belongs_to :action, polymorphic: true
  belongs_to :recipient, polymorphic: true
  belongs_to :action_attribute_changed_by, polymorphic: true
  belongs_to :application

  validate :subject_id, presence: true
  validate :action_id, presence: true
  validate :recipient_id, presence: true

  scope :for, -> (recipient, application_id) { where(recipient: recipient, application_id: application_id).order('updated_at DESC') }

  def self.create_with(action, subject, recipient, app_id, action_attribute = nil, action_attribute_changed_by = nil)
    notification_attributes = {
      action: action,
      subject: subject,
      recipient: recipient,
      application_id: app_id,
      action_attribute: action_attribute,
      action_attribute_changed_by: action_attribute_changed_by
    }.delete_if { |k,v| v.blank? && k.to_s =~ /^action_attribute/ }
    unless where(notification_attributes).first
      new(notification_attributes).save!
    end
  end

  def self.notify(action, subject, app_id, action_attribute = nil, action_attribute_changed_by = nil)
    self.notify_group(subject.subscribers, action, app_id, action_attribute, action_attribute_changed_by)
  end

  def self.notify_group(group, action, subject, app_id, action_attribute = nil, action_attribute_changed_by = nil)
    NotificationCreator.new(
      action,
      subject,
      app_id,
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

  def action_user_image
    action_attribute_changed_by ? changed_by_avatar : creator_avatar
  end

  def text
    action.notification_text(recipient, action_attribute, action_attribute_changed_by)
  end

  def time
    self.created_at
  end

  private

  def creator_avatar
    action.creator.gravatar_url
  end

  def changed_by_avatar
    Customer.find(action_attribute_changed_by).gravatar_url
  end
end

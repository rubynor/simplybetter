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

  def self.create_with(action: ,subject:, recipient:, app_id:, **args)
    notification_attributes = {
      action: action,
      subject: subject,
      recipient: recipient,
      application_id: app_id,
      action_attribute: args[:action_attr],
      action_attribute_changed_by: args[:action_attr_changer]
    }.delete_if { |k,v| v.blank? && k.to_s =~ /^action_attribute/ }
    unless where(notification_attributes).first
      new(notification_attributes).save!
    end
  end

  def self.notify(action:, subject:, app_id:, **args)
    self.notify_group(group: subject.subscribers, action: action, subject: subject, app_id: app_id, action_attr: args[:action_attr], action_attr_changer: args[:action_attr_changer])
  end

  def self.notify_group(group:, action:, subject:, app_id:, **args)
    NotificationCreator.new(
      action: action,
      subject: subject,
      app_id: app_id,
      action_attr: args[:action_attr],
      action_attr_changer: args[:action_attr_changer]
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
    action.notification_text(recipient, action_attr: action_attribute, action_attr_changer: action_attribute_changed_by)
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

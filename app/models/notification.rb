class Notification < ActiveRecord::Base
  belongs_to :subject, polymorphic: true
  belongs_to :action, polymorphic: true
  belongs_to :recipient, polymorphic: true

  def self.notify(action, subject)
    notify_group(subject.subscribers, action, subject)
  end

  def self.notify_group(group, action, subject)
    group.each do |u|
      unless action.creator == u
        create(action: action, subject: subject, recipient: u)
      end
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
    self.action.notification_text(recipient)
  end

  def time
    self.created_at
  end
end

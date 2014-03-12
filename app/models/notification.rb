class Notification < ActiveRecord::Base
  belongs_to :subject, polymorphic: true
  belongs_to :action, polymorphic: true
  belongs_to :recipient, polymorphic: true

  def self.notify(action, subject)
    subject.subscribers.each do |s|
      unless action.creator == s
        create(action: action, subject: subject, recipient: s)
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

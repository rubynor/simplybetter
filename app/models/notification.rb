class Notification < ActiveRecord::Base
  belongs_to :subject, polymorphic: true
  belongs_to :action, polymorphic: true
  belongs_to :recipient, polymorphic: true

  def self.notify(action, subject)
    subject.subscribers.each do |s|
      create(action: action, subject: subject, recipient: s)
    end
  end

  def self.for(recipient)
    all.where(recipient: recipient)
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

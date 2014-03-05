class Notification < ActiveRecord::Base
  belongs_to :subject, polymorphic: true
  belongs_to :action, polymorphic: true
  belongs_to :recipient, polymorphic: true

  def action_user_image
    self.action.creator.gravatar_url
  end

  def text
    self.action.notification_text
  end

  def time
    self.created_at
  end
end

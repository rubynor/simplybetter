class EmailSetting < ActiveRecord::Base
  belongs_to :mailable, polymorphic: true

  before_create :set_email_unsubscribe_token

  def self.unsubscribed?(mailable)
    find_or_create_by(mailable: mailable).unsubscribed
  end

  def self.unsubscribe!(unsubscribe_token)
    email_setting = find_by(unsubscribe_token: unsubscribe_token)
    unless email_setting
      raise ArgumentError, "Could not find an email setting based on this unsubscribe_token: #{unsubscribe_token}"
    end

    if email_setting.unsubscribed?
      "You are already unsubscribed from email notifications"
    else
      email_setting.update_attributes!(unsubscribed: true)
      "You have been unsubscribed from email notifications"
    end
  end

  def set_email_unsubscribe_token
    self.unsubscribe_token = SecureRandom.urlsafe_base64
  end
end

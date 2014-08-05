class EmailSetting < ActiveRecord::Base
  belongs_to :mailable, polymorphic: true

  before_create :set_email_unsubscribe_token

  def get_or_set_unsubscribe_token
    unless unsubscribe_token
      set_email_unsubscribe_token()
      save!
    end
    self.unsubscribe_token
  end

  def self.unsubscribed?(mailable)
    find_or_create_by(mailable: mailable).unsubscribed
  end

  def set_email_unsubscribe_token
    self.unsubscribe_token = SecureRandom.urlsafe_base64
  end
end

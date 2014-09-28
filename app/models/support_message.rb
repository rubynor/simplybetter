class SupportMessage < ActiveRecord::Base

  belongs_to :user, polymorphic: true, inverse_of: :support_messages
  belongs_to :application

  validates_presence_of :user_id, :application_id, :message, :to, :from

  def save_and_send
    SupportMailer.send_to_support(self).deliver
    self.sent_at = Time.now
    save
  end

  def app_name
    application.name
  end

  def name_or_email
    self.user.try(:name) || self.user.email
  end
end

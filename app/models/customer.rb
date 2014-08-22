class Customer < ActiveRecord::Base
  include AbuseReporter
  has_paper_trail
  include Gravtastic
  gravtastic size: 50
  has_secure_password
  has_and_belongs_to_many :applications
  has_and_belongs_to_many :widgets, class_name: 'Application', join_table: 'widget_customers'

  has_many :comments, inverse_of: :creator
  has_many :votes, as: :voter
  has_one :email_setting, as: :mailable, dependent: :destroy
  validates_presence_of :name, :password_digest
  validates :email,
    format: {
      with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i,
      on: :create},
    uniqueness: true,
    presence: true

  before_create { generate_token(:auth_token) }

  def send_password_reset
    generate_token(:password_reset_token)
    self.password_reset_sent_at = Time.zone.now
    save!
    CustomerMailer.password_reset(self).deliver
  end

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while Customer.exists?(column => self[column])
  end
end

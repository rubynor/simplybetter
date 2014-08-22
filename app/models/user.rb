class User < ActiveRecord::Base
  include AbuseReporter
  has_paper_trail
  include Gravtastic
  gravtastic size: 50
  has_and_belongs_to_many :widgets, class_name: 'Application', join_table: 'widget_users'
  has_many :comments, as: :creator, inverse_of: :creator
  has_many :ideas, as: :creator
  has_many :votes, as: :voter
  has_one :email_setting, as: :mailable, dependent: :destroy

  validates :email,
    format: {
      with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, 
      on: :create},
    uniqueness: true,
    presence: true

end

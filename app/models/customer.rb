class Customer < ActiveRecord::Base
  has_paper_trail
  include Gravtastic
  gravtastic size: 50
  has_secure_password
  has_many :applications, dependent: :destroy
  has_many :comments, inverse_of: :creator
  has_many :votes, as: :voter
  validates :email, 
    format: {
      with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, 
      on: :create},
    uniqueness: true,
    presence: true
end

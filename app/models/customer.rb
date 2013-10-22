class Customer < ActiveRecord::Base
  include Gravtastic
  gravtastic size: 50
  has_secure_password
  has_many :applications, dependent: :destroy
  has_many :comments, inverse_of: :creator
  validates :email, uniqueness: true, presence: true
end

class Customer < ActiveRecord::Base
  has_secure_password
  has_many :applications, dependent: :destroy
  has_many :comments, inverse_of: :creator
  validates :email, uniqueness: true, presence: true
end

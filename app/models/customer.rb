class Customer < ActiveRecord::Base
  has_secure_password
  has_many :applications
  has_many :comments, inverse_of: :creator
end

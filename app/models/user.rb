class User < ActiveRecord::Base

  validates_presence_of :email
  has_many :comments, as: :creator
  has_many :features
  has_many :votes

end

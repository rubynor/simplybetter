class User < ActiveRecord::Base

  validates_presence_of :email
  has_many :comments
  has_many :features
  has_many :votes

end

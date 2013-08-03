class User < ActiveRecord::Base

  validates_presence_of :email
  belongs_to :application
  has_many :comments, as: :creator
  has_many :features, as: :creator
  has_many :votes

end

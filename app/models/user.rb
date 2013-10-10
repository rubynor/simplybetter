class User < ActiveRecord::Base

  validates :email, uniqueness: true, presence: true
  belongs_to :application
  has_many :comments, as: :creator, inverse_of: :creator
  has_many :features, as: :creator
  has_many :votes

end

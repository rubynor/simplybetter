class Feature < ActiveRecord::Base
  belongs_to :customer
  has_many :votes
  has_many :comments

  validates_presence_of :title, :description
end

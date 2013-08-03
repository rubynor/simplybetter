class Feature < ActiveRecord::Base
  belongs_to :application
  has_many :votes
  has_many :comments

  validates_presence_of :title, :description
  validates_uniqueness_of :title

end

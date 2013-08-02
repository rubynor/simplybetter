class Feature < ActiveRecord::Base
  belongs_to :customer
  has_many :votes

  validates_presence_of :title, :description
end

class Feature < ActiveRecord::Base
  belongs_to :application
  has_many :votes

  validates_presence_of :title, :description
end

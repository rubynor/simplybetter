class Feature < ActiveRecord::Base
  belongs_to :application
  belongs_to :creator, polymorphic: true
  has_many :votes, as: :vote_receiver
  has_many :comments, inverse_of: :feature

  validates_presence_of :title, :description
  validates_uniqueness_of :title

  def update_votes_count
    self.update_attribute(:votes_count, votes.sum(:value))
  end

end

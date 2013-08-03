class Feature < ActiveRecord::Base
  belongs_to :application
  has_many :votes, as: :vote_receiver
  has_many :comments

  validates_presence_of :title, :description
  validates_uniqueness_of :title

  def update_votes_count
    self.update_attribute(:votes_count, votes.sum(:value))
  end

end

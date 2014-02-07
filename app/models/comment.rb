class Comment < ActiveRecord::Base
  belongs_to :idea, inverse_of: :comments
  has_many :votes, as: :vote_receiver

  validates_presence_of :body, :idea, :creator
  belongs_to :creator, polymorphic: true, inverse_of: :comments

  def creator_name
    creator.name
  end

  def update_votes_count
    self.update_attribute(:votes_count, votes.sum(:value))
  end
end

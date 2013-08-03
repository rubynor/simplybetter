class Comment < ActiveRecord::Base
  has_many :votes, as: :vote_receiver

  validates_presence_of :body, :feature_id, :user_id

  belongs_to :feature

  def update_votes_count
    self.update_attribute(:votes_count, votes.sum(:value))
  end
end

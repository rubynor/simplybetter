class Comment < ActiveRecord::Base
  belongs_to :feature, inverse_of: :comments
  has_many :votes, as: :vote_receiver

  validates_presence_of :body, :feature, :user_id

  def update_votes_count
    self.update_attribute(:votes_count, votes.sum(:value))
  end
end

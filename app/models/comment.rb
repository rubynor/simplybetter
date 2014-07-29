class Comment < ActiveRecord::Base
  has_paper_trail
  belongs_to :idea, inverse_of: :comments
  has_many :votes, as: :vote_receiver
  has_one :idea_subscription, as: :subscriber_from, dependent: :destroy 

  validates_presence_of :body, :idea, :creator
  belongs_to :creator, polymorphic: true, inverse_of: :comments

  include CommentNotificationHelpers

  scope :visible, -> { where(visible: true) }

  def subscribe
    IdeaSubscription.add(self, self.creator, self.idea)
  end

  def creator_name
    creator.name
  end

  def update_votes_count
    self.update_attribute(:votes_count, votes.sum(:value))
  end

  def customers
    idea.customers
  end

  def idea_creator
    [self.idea.creator]
  end

end

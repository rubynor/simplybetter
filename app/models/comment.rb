class Comment < ActiveRecord::Base
  has_paper_trail
  belongs_to :idea, inverse_of: :comments
  has_many :votes, as: :vote_receiver
  has_one :idea_subscription, as: :subscriber_from, dependent: :destroy 

  validates_presence_of :body, :idea, :creator
  belongs_to :creator, polymorphic: true, inverse_of: :comments

  after_create :notify_involved

  include CommentNotificationHelpers

  def subscribe
    IdeaSubscription.add(self, self.creator, self.idea)
  end

  def creator_name
    creator.name
  end

  def update_votes_count
    self.update_attribute(:votes_count, votes.sum(:value))
  end

  def notify_involved
    involved_users.each do |i|
      unless i.email == self.creator.email
        UserNotifier.new_comment(i,self.creator,self).deliver
      end
    end
  end

  def involved_users
    (voters + commenters + idea_creator).uniq(&:email)
  end

  def voters
    voters = self.idea.votes.includes(:voter)
    voters.map(&:voter)
  end

  def commenters
    commenters = self.idea.comments.includes(:creator)
    commenters.map(&:creator)
  end

  def idea_creator
    [self.idea.creator]
  end

end

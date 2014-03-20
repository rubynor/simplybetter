class Idea < ActiveRecord::Base
  has_paper_trail
  searchkick autocomplete: [:title]

  belongs_to :application
  belongs_to :creator, polymorphic: true
  has_many :votes, as: :vote_receiver, dependent: :destroy
  has_many :comments, inverse_of: :idea, dependent: :destroy
  has_many :idea_subscriptions, dependent: :destroy
  has_many :notifications, as: :subject, dependent: :destroy

  validates_presence_of :title, :description, :creator
  validates_uniqueness_of :title, scope: :application

  include IdeaNotificationHelpers

  scope :visible, -> { where(visible: true) }

  def subscribers
    self.idea_subscriptions.map(&:subscriber).uniq
  end

  def subscribe
    IdeaSubscription.add(self, self.creator, self)
  end

  def mine?(user)
    self.creator == user
  end

  def upvotes
    votes.where("value > 0").count
  end

  def downvotes
    votes.where("value < 0").count
  end 

  def voter_status(voter)
    votes.find_by(voter: voter).try(:value) if voter
  end

  def update_votes_count
    self.update_attribute(:votes_count, votes.sum(:value))
  end

  def self.find_creator(string)
    string_arry = string.split(",")
    klass = string_arry.first
    id = string_arry.last.to_i
    klass.constantize.find id
  end

  def has_been_completed?
    self.completed_changed? && self.completed == true
  end

  private

  def self.application(token)
    Application.find_by(token: token)
  end
end

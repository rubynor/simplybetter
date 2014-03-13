class Idea < ActiveRecord::Base
  has_paper_trail
  searchkick autocomplete: [:title]

  belongs_to :application
  belongs_to :creator, polymorphic: true
  belongs_to :idea_group
  has_many :votes, as: :vote_receiver, dependent: :destroy
  has_many :comments, inverse_of: :idea, dependent: :destroy
  has_many :idea_subscriptions, dependent: :destroy

  validates_presence_of :title, :description, :creator
  validates_uniqueness_of :title, scope: :application

  after_create :email_notify_customers

  def subscribers
    self.idea_subscriptions.map(&:subscriber).uniq
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

  def self.ideas_in_group(token)
    application(token).idea_group.ideas
  end

  def notify_customers
    Notification.notify_group([self.application.customer], self, self)
  end

  def subscribe
    IdeaSubscription.add(self, self.creator, self)
  end

  def email_notify_customers
    Thread.new do
      AdminNotifier.new_idea(self.application.customer,self.creator, self).deliver
    end
  end

  def notification_text(recipient)
    [
      {bold: "#{creator.name} "},
      {normal: "added an idea: "},
      {bold: "“#{title}”"}
    ]
  end

  private

  def self.application(token)
    Application.find_by(token: token)
  end

end

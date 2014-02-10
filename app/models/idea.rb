class Idea < ActiveRecord::Base
  has_paper_trail
  searchkick autocomplete: [:title]

  belongs_to :application
  belongs_to :creator, polymorphic: true
  belongs_to :idea_group
  has_many :votes, as: :vote_receiver
  has_many :comments, inverse_of: :idea

  validates_presence_of :title, :description, :creator
  validates_uniqueness_of :title, scope: :application

  def upvotes
    votes.where("value > 0").count
  end

  def downvotes
    votes.where("value < 0").count
  end 

  def update_votes_count
    self.update_attribute(:votes_count, votes.sum(:value))
  end



  def self.ideas_in_group(token)
    application(token).idea_group.ideas
  end

  private

  def self.application(token)
    Application.find_by(token: token)
  end

end

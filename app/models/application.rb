class Application < ActiveRecord::Base
  has_paper_trail
  belongs_to :customer
  has_one :idea_group
  has_many :users
  has_many :ideas, -> { order("votes_count DESC") }
  has_many :comments, -> { order("comments.votes_count DESC") }, through: :ideas

  validates_uniqueness_of :token

  before_create :generate_token, :create_idea_group

  def idea_group
    IdeaGroup.find_or_create_by(application_id: self.id)
  end

  def ideas_not_in_group
    self.ideas.where("idea_group_id IS NULL or idea_group_id != ?", self.idea_group.id)
  end

  private

  def generate_token
    self.token = (0...8).map{(65+rand(26)).chr}.join
  end
end

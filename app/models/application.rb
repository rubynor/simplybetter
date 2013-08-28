class Application < ActiveRecord::Base
  belongs_to :customer
  belongs_to :feature_group
  has_many :users
  has_many :features, -> { order("votes_count DESC") }
  has_many :comments, -> { order("comments.votes_count DESC") }, through: :features

  validates_uniqueness_of :token

  before_create :generate_token, :create_feature_group

  def feature_group
    FeatureGroup.find_or_create_by(application_id: self.id)
  end

  private

  def generate_token
    self.token = (0...8).map{(65+rand(26)).chr}.join
  end
end

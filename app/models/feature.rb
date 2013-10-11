class Feature < ActiveRecord::Base
  belongs_to :application
  belongs_to :creator, polymorphic: true
  belongs_to :feature_group
  has_many :votes, as: :vote_receiver
  has_many :comments, inverse_of: :feature

  validates_presence_of :title, :description
  validates_uniqueness_of :title, scope: :application

  def update_votes_count
    self.update_attribute(:votes_count, votes.sum(:value))
  end



  def self.features_in_group(token)
    application(token).feature_group.features
  end

  private

  def self.application(token)
    Application.find_by(token: token)
  end

end

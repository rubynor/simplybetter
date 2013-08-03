class Vote < ActiveRecord::Base

  belongs_to :feature
  after_save :update_parent_votes_count

  validates_format_of :voter_email, with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create
  validates_uniqueness_of :voter_email, scope: :feature_id, message: "has already voted"


  protected

  def update_parent_votes_count
    feature.update_votes_count
  end

end

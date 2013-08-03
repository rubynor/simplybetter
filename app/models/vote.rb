class Vote < ActiveRecord::Base
  belongs_to :feature

  validates_format_of :voter_email, with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create

  #TODO: Check if Vote.find_by_voter_email exist && update value.
  #TODO: Composite Key: (feature, voter_email) should be unique (validation)
  #TODO: counter cache
  def Vote.vote_count
    Vote.all.collect(&:value).reduce(&:+)
  end

end

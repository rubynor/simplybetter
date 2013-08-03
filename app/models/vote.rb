class Vote < ActiveRecord::Base
  belongs_to :feature

  validates_format_of :voter_email, with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create

  def Vote.vote_count
    Vote.all.collect(&:value).reduce(&:+)
  end

end

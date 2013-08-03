class Vote < ActiveRecord::Base

  validates_presence_of :voter_email
  validates_format_of :voter_email, with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create

  def Vote.vote_count
    Vote.all.collect(&:value).reduce(&:+)
  end

end

class Vote < ActiveRecord::Base
  has_paper_trail
  belongs_to :vote_receiver, polymorphic: true
  belongs_to :voter, polymorphic: true
  after_save :update_parent_votes_count

  def cast(value)
    if self.value == 1 && value == 1
      self.value = 0
    elsif self.value == -1 && value == -1
      self.value = 0
    elsif value == 0
      return
    else
      self.value = 0
      self.value += value
    end
    self.save!
  end

  protected

  def update_parent_votes_count
    vote_receiver.update_votes_count
  end

end

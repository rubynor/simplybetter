class Vote < ActiveRecord::Base
  #belongs_to :caster, :class_name => User

  def Vote.vote_count
    Vote.all.collect(&:value).reduce(&:+)
  end

end

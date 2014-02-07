class IdeaGroup < ActiveRecord::Base
  has_many :ideas
  belongs_to :application
end

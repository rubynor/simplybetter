class Comment < ActiveRecord::Base

  validates_presence_of :body, :feature_id, :creator_id, :creator_type
  belongs_to :creator, polymorphic: true
  belongs_to :feature
end

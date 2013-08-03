class Comment < ActiveRecord::Base

  validates_presence_of :body, :feature_id, :user_id

  belongs_to :feature
end

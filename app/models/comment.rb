class Comment < ActiveRecord::Base

  validates_presence_of :body, :user_id, :feature_id
end

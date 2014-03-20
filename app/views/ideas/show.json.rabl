object @idea
attributes :id, :title, :description, :updated_at, :votes_count, :visible, :completed

node(:updated_at) do |c|
  c.updated_at.strftime('%F')
end

glue(:creator) do
  attributes :name => :creator_name
end

node(:upvotes) do |c|
  c.upvotes
end

node(:downvotes) do |c|
  c.downvotes
end

node(:comments_count) do |c|
  c.comments.count
end

node(:voter_status) do |c|
  c.voter_status(@current_user)
end

child(:comments) do
  extends "widget_api/comments/show"
end


object @idea
attributes :id, :title, :description, :updated_at, :votes_count, :completed

node(:updated_at) do |c|
  c.updated_at.strftime('%F')
end

glue(:creator) do
  attributes :name => :creator_name
  attributes :email => :creator_email
end

node(:comments_count) do |c|
  c.comments.visible.count
end

node(:voter_status) do |c|
  c.voter_status(current_user)
end


object @idea
attributes :id, :title, :description, :updated_at, :votes_count

node(:updated_at) do |c|
  c.updated_at.strftime('%F')
end

glue(:creator) do
  attributes :name => :creator_name
end

node(:comments_count) do |c|
  c.comments.count
end


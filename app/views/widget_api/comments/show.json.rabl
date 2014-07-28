object @comment
attributes :id, :body, :creator_name, :visible

node(:updated_at) do |c|
  c.updated_at.strftime('%F')
end

node(:gravatar_url) do |c|
  c.creator.gravatar_url
end


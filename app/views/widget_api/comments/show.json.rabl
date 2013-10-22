object @comment
attributes :body, :creator_name

node(:updated_at) do |c|
  c.updated_at.strftime('%F')
end

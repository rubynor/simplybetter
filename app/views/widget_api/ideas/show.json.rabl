object @idea
attributes :id, :title, :description, :created_at, :updated_at, :votes_count, :completed, :visible

node(:updated_at) do |c|
  c.updated_at.strftime('%F')
end

node(:created_at) do |c|
  c.created_at.strftime('%F')
end

glue(:creator) do
  attributes :name => :creator_name
  attributes :email => :creator_email
end

node(:comments_count) do |c|
  c.comments.visible.count
end

node(:voter_status) do |c|
  c.voter_status(@current_user)
end

child(:last_edit_admin => :last_edit_admin) do
  attributes :name, :gravatar_url
end

node(:last_edit_admin_time) do |c|
  c.last_edit_admin_time.strftime('%F') if c.last_edit_admin_time.present?
end

collection @collaborators
attributes :id, :email, :name

node :gravatar_url do |c|
  c.gravatar_url(size: 30)
end

node :is_me do |c|
  current_customer == c
end

node :owner do |c|
  @application.owner == c
end

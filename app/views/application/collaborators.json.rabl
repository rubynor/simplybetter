collection @collaborators
attributes :email, :name

node :gravatar_url do |c|
  c.gravatar_url(size: 30)
end

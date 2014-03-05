require 'machinist/active_record'

# Add your blueprints here.
#
# e.g.
#   Post.blueprint do
#     title { "Post #{sn}" }
#     body  { "Lorem ipsum..." }
#   end

Application.blueprint do
  customer
end

Idea.blueprint do
  application
  title { "New idea" }
  description { "Seriously, how hard can it be to move a todo list" }
end

Customer.blueprint do
  name { "Acme Inc" }
  email { "test@example.com" }
  password { "secret" }
  password_confirmation { "secret" }
end

Comment.blueprint do
  creator { User.make! }
  idea
  body { 'Hello bro' }
end

User.blueprint do
  name { "Machinist user" }
  email { "test@machinist.com" }
end

Vote.blueprint do
  vote_receiver { Idea.make! }
  voter_email { "test@example.com"}
  value { 1 }
end

IdeaSubscription.blueprint do
  # Attributes here
end

Notification.blueprint do
  # Attributes here
end

require 'machinist/active_record'

# Add your blueprints here.
#
# e.g.
#   Post.blueprint do
#     title { "Post #{sn}" }
#     body  { "Lorem ipsum..." }
#   end

Application.blueprint do
  name { "Test application" }
  owner { Customer.make! }
end

Idea.blueprint do
  application
  title { "New idea" }
  description { "Seriously, how hard can it be to move a todo list" }
  creator { Customer.make! }
end

Customer.blueprint do
  name { "Acme Inc" }
  email { "customer-#{sn}@example.com" }
  password { "dev" }
  password_confirmation { "dev" }
  email_setting
end

Customer.blueprint(:with_apps) do
  applications(1)
end

Comment.blueprint do
  creator { User.make! }
  idea
  body { 'Hello bro' }
end

User.blueprint do
  name { "Machinist user" }
  email { "user-#{sn}@machinist.com" }
  email_setting
end

EmailSetting.blueprint do
end

Vote.blueprint do
  vote_receiver { Idea.make! }
  voter { User.make! }
  value { 1 }
end

IdeaSubscription.blueprint do
  # Attributes here
end

Notification.blueprint do
  # Attributes here
end

SupportMessage.blueprint do
  # Attributes here
end

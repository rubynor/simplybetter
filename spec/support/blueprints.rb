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

Feature.blueprint do
  application
  title { "New feature" }
  description { "Seriously, how hard can it be to move a todo list" }
end

Customer.blueprint do
  name { "Acme Inc" }
  email { "test@example.com" }
  password { "secret" }
  password_confirmation { "secret" }
end

Comment.blueprint do
  user_id { sn }
  feature_id { Feature.make!.id }
  body { 'Hello bro' }
end

Vote.blueprint do
  feature
  voter_email { "test@example.com"}
  value { 1 }
end

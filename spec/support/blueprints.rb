require 'machinist/active_record'

# Add your blueprints here.
#
# e.g.
#   Post.blueprint do
#     title { "Post #{sn}" }
#     body  { "Lorem ipsum..." }
#   end

Feature.blueprint do
  customer
  title { "New feature" }
  description { "Seriously, how hard can it be to move a todo list" }
end

Vote.blueprint do
  # Attributes here
end

Customer.blueprint do
  token { (0...8).map{(65+rand(26)).chr}.join }
end

Comment.blueprint do
  user_id { User.make!.id }
  feature_id { Feature.make!.id }
  body { 'Hello bro' }
end

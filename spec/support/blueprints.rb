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
end

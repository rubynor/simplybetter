object @notification
attributes :id, :checked

node :image_url do |n|
  n.action_user_image
end

node :text do |n|
  n.text
end

node :time do |n|
  n.time
end

node :idea_id do |n|
  n.idea
end

node :comment_id do |n|
  n.comment
end


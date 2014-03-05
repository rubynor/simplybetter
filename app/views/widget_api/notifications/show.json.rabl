object @notification
attributes :id, :checked

node :image_url |n|
  n.action_user_image
end

node :text |n|
  n.text
end

node :time |n|
  n.time
end


json.array!(@features) do |feature|
  json.extract! feature, :id, :title, :description, :created_at, :updated_at, :votes_count
  json.creator_name feature.creator.name
  json.url feature_url(feature, format: :js)

  json.comments feature.comments, :id, :feature_id, :body, :votes_count, :creator_name, :created_at
end
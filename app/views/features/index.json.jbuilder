json.array!(@features) do |feature|
  json.extract! feature, :title, :description, :crator_id
  json.url feature_url(feature, format: :json)
end

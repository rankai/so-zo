json.array!(@watches) do |watch|
  json.extract! watch, :id, :user_id, :watched_user_id
  json.url watch_url(watch, format: :json)
end

json.array!(@collections) do |collection|
  json.extract! collection, :id, :user_id, :publish_id
  json.url collection_url(collection, format: :json)
end

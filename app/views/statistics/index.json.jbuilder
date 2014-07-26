json.array!(@statistics) do |statistic|
  json.extract! statistic, :id, :object_id, :object_type, :action, :count
  json.url statistic_url(statistic, format: :json)
end

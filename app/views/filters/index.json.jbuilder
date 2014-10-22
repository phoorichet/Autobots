json.array!(@filters) do |filter|
  json.extract! filter, :id, :name, :description, :multiple, :data, :metric_id
  json.url filter_url(filter, format: :json)
end

json.array!(@metrics) do |metric|
  json.extract! metric, :id, :name, :settings, :model_name, :attr, :transform, :service_id
  json.url metric_url(metric, format: :json)
end

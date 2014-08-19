json.array!(@time_configs) do |time_config|
  json.extract! time_config, :id, :name, :description, :reps, :time_type
  json.url time_config_url(time_config, format: :json)
end

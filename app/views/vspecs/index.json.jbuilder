json.array!(@vspecs) do |vspec|
  json.extract! vspec, :id, :name, :value, :metric_id
  json.url vspec_url(vspec, format: :json)
end

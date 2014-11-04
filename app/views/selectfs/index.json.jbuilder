json.array!(@selectfs) do |selectf|
  json.extract! selectf, :id, :field, :selected, :metric_id
  json.url selectf_url(selectf, format: :json)
end

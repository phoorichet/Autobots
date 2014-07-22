json.array!(@metric_https) do |metric_http|
  json.extract! metric_http, :id, :region, :location, :rncname, :mobile_code, :imei, :imsi, :script_name, :apn, :serviceinfo, :attempt, :success, :http_succ_rate
  json.url metric_http_url(metric_http, format: :json)
end

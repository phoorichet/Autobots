json.array!(@metric_youtubes) do |metric_youtube|
  json.extract! metric_youtube, :id, :region, :location, :rncname, :mobile_code, :imei, :imsi, :script_name, :attempt, :success, :quality, :youtube_succ_rate, :youtube_qual_rate, :youtube_rate
  json.url metric_youtube_url(metric_youtube, format: :json)
end

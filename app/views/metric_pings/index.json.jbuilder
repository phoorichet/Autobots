json.array!(@metric_pings) do |metric_ping|
  json.extract! metric_ping, :id, :region, :location, :rncname, :mobile_code, :imei, :imsi, :target_ip, :attempt, :percent_loss, :avg_packet_loss_rate, :avg_rtt_succ_rate
  json.url metric_ping_url(metric_ping, format: :json)
end

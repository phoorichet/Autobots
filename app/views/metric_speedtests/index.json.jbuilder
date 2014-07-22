json.array!(@metric_speedtests) do |metric_speedtest|
  json.extract! metric_speedtest, :id, :region, :location, :rncname, :mobile_code, :imei, :imsi, :script_name, :set_server_name, :attempt, :download_1mbps, :speedtest_dl_1m_rate, :download_2mbps, :speedtest_dl_2m_rate, :upload_300kbps, :speedtest_ul_300k_rate, :upload_1mkbps, :speedtest_ul_1m_rate, :latency_300ms, :speedtest_lt_300k_rate
  json.url metric_speedtest_url(metric_speedtest, format: :json)
end

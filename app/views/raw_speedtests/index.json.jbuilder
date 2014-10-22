json.array!(@raw_speedtests) do |raw_speedtest|
  json.extract! raw_speedtest, :id, :imei, :imsi, :technology, :datetime, :download, :upload, :latency, :server_id, :server_name, :avg_ecio, :avg_rssi, :mcc, :mcc, :lac, :cell_id, :script_name, :operator, :result, :set_server_id, :set_server_name, :apn
  json.url raw_speedtest_url(raw_speedtest, format: :json)
end

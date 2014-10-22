json.array!(@raw_pings) do |raw_ping|
  json.extract! raw_ping, :id, :imei, :imsi, :technology, :datetime, :packet_sent, :packet_received, :packet_lost, :rtt_min, :rtt_max, :rtt_mdev, :apn, :apn_mcc, :apn_mnc, :ip, :lac, :cell_id, :script_name, :packet_size
  json.url raw_ping_url(raw_ping, format: :json)
end

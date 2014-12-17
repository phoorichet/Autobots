json.array!(@raw_https) do |raw_http|
  json.extract! raw_http, :id, :connecting_time_1, :time_to_first_byte_1, :result_1, :result_detail_1, :imei, :imsi, :script_name, :service, :service_info, :avg_rssi, :avg_rxlev, :avg_ecio, :cell_id, :lac, :start_date, :stop_date, :duration_time, :data_download_transfer, :max_download, :max_download_overall, :min_download, :throughput_download_ip, :throughput_download_app, :throughput_download_rlc, :result, :lat, :lon, :apn
  json.url raw_http_url(raw_http, format: :json)
end

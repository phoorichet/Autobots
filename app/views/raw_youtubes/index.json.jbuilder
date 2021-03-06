json.array!(@raw_youtubes) do |raw_youtube|
  json.extract! raw_youtube, :id, :imei, :imsi, :script_name, :operator, :technology, :avg_rssi, :avg_rxlen, :avg_ecio, :cell_id, :lac, :start_time, :stop_time, :duration_time, :data_download_transfer, :throughput_download_app, :throughput_download_rlc, :result, :result_detail, :youtube_video_duration, :lat, :lon, :apn
  json.url raw_youtube_url(raw_youtube, format: :json)
end

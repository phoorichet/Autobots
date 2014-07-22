##############
rails g scaffold MetricPing region:string location:string rncname:string mobile_code:string imei:string imsi:string target_ip:string attempt:integer percent_loss:float avg_packet_loss_rate:float avg_rtt_succ_rate:float

rails g scaffold MetricHttp region:string location:string rncname:string mobile_code:string imei:string imsi:string script_name:string apn:string serviceinfo:string attempt:integer success:integer http_succ_rate:float

rails g scaffold MetricSpeedtest region:string location:string rncname:string mobile_code:string imei:string imsi:string script_name:string set_server_name:string attempt:integer download_1mbps:integer speedtest_dl_1m_rate:float download_2mbps:integer speedtest_dl_2m_rate:float upload_300kbps:integer speedtest_ul_300k_rate:float upload_1mkbps:integer speedtest_ul_1m_rate:float latency_300ms:integer speedtest_lt_300k_rate:float

rails g scaffold MetricYoutube region:string location:string rncname:string mobile_code:string imei:string imsi:string script_name:string attempt:integer success:integer quality:integer youtube_succ_rate:float youtube_qual_rate:float youtube_rate:float
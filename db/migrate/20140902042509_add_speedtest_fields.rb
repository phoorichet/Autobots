class AddSpeedtestFields < ActiveRecord::Migration
  # {:date_time=>Thu, 28 Aug 2014 16:30:00 +0700, :region=>"South", :location=>"_____________________", :rncname=>"3RNCHYI3H", :sgsn_name=>"3SGSNTWA3H", :mobile_code=>"E2E-042", :imei=>355101000000000.0, :imsi=>520030000000000.0, :script_name=>"Speedtest_Set2.txt", :set_server_name=>"AIS", :site=>"CWD", :server_id=>3147, :server_name=>"Bangkok", :internal_ip=>"10.130.223.169", :external_ip=>"49.230.62.253", :apn=>"3GGSNCWD3N", :lat=>nil, :lon=>nil, :cell_id=>23873, :lac=>4835, :technology=>"HSPA+", :avg_rssi=>-57.16, :avg_rxlev=>nil, :avg_ecio=>-5.37, :attempt=>1, :download_1mbps=>1, :speedtest_dl_1m_rate=>100, :download_2mbps=>1, :speedtest_dl_2m_rate=>100, :upload_300kbps=>1, :speedtest_ul_300k_rate=>100, :upload_1mkbps=>1, :speedtest_ul_1m_rate=>100, :latency_300ms=>1, :speedtest_lt_300k_rate=>100, :created_at=>Thu, 28 Aug 2014 16:30:00 +0700}
  def change
    add_column :metric_speedtests, :apn, :string
    add_column :metric_speedtests, :site, :string
    add_column :metric_speedtests, :server_id, :integer
    add_column :metric_speedtests, :server_name, :string
    add_column :metric_speedtests, :internal_ip, :string
    add_column :metric_speedtests, :external_ip, :string
    add_column :metric_speedtests, :sgsn_name, :string
    add_column :metric_speedtests, :lat, :float
    add_column :metric_speedtests, :lon, :float
    add_column :metric_speedtests, :cell_id, :string
    add_column :metric_speedtests, :lac, :string
    add_column :metric_speedtests, :technology, :string
    add_column :metric_speedtests, :avg_rssi, :float
    add_column :metric_speedtests, :avg_rxlev, :float
    add_column :metric_speedtests, :avg_ecio, :float

  end
end

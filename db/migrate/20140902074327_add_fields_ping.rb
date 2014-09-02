class AddFieldsPing < ActiveRecord::Migration
  #{:date_time=>Thu, 28 Aug 2014 08:18:00 +0700, :region=>"Northeast", :location=>"_______________________", :rncname=>"3RNCNMA5Z", :sgsn_name=>"3SGSNBPL2H", :mobile_code=>"E2E-012", :imei=>355101000000000.0, :imsi=>520030000000000.0, :script_name=>"Ping14_Set1.txt", :site=>"SUK", :apn=>"3GGSNSUK11H", :ip=>"100.84.134.60", :lac=>1325, :cell_id=>12502, :target_host=>"115.178.59.11", :target_ip=>"115.178.59.11", :packet_sent=>4, :packet_received=>4, :packet_lost=>0, :rtt_min=>34.519, :rtt_avg=>35.724, :rtt_max=>37.632, :rtt_mdev=>1.256, :percent_loss=>0, :attempt=>0, :success=>0, :avg_rtt_succ_rate=>0, :created_at=>Thu, 28 Aug 2014 08:18:00 +0700}
  def change
    add_column :metric_pings, :apn, :string
    add_column :metric_pings, :site, :string
    add_column :metric_pings, :ip, :string
    add_column :metric_pings, :technology, :string
    add_column :metric_pings, :sgsn_name, :string
    add_column :metric_pings, :script_name, :string
    add_column :metric_pings, :lat, :float
    add_column :metric_pings, :lon, :float
    add_column :metric_pings, :cell_id, :string
    add_column :metric_pings, :lac, :string
    add_column :metric_pings, :avg_rssi, :float
    add_column :metric_pings, :avg_rxlev, :float
    add_column :metric_pings, :avg_ecio, :float
    add_column :metric_pings, :target_host, :string
    add_column :metric_pings, :packet_sent, :integer
    add_column :metric_pings, :packet_received, :integer
    add_column :metric_pings, :packet_lost, :integer
    add_column :metric_pings, :rtt_min, :float
    add_column :metric_pings, :rtt_avg, :float
    add_column :metric_pings, :rtt_max, :float
    add_column :metric_pings, :rtt_mdev, :float
    add_column :metric_pings, :success, :integer
  end
end

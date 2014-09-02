class AddFieldsYoutube < ActiveRecord::Migration
  # {:date_time=>Thu, 28 Aug 2014 15:30:00 +0700, :region=>"Northeast", :location=>"__________________", :rncname=>"3RNCNMA1Z", :sgsn_name=>"3SGSNBPL2H", :mobile_code=>"E2E-037", :imei=>355101000000000.0, :imsi=>520030000000000.0, :script_name=>"Youtube_Set2.txt", :site=>"TLS", :apn=>"3GGSNTLS1H", :cell_id=>18101, :lac=>5305, :technology=>"HSPA+", :ip=>"10.43.147.108", :lat=>nil, :lon=>nil, :avg_rssi=>-40.0092592593, :avg_rxlev=>nil, :avg_ecio=>-4.1620475735, :attempt=>1, :success=>1, :quality=>1, :youtube_succ_rate=>100, :youtube_qual_rate=>100, :youtube_rate=>100, :created_at=>Thu, 28 Aug 2014 15:30:00 +0700}
  def change
    add_column :metric_youtubes, :apn, :string
    add_column :metric_youtubes, :site, :string
    add_column :metric_youtubes, :ip, :string
    add_column :metric_youtubes, :technology, :string
    add_column :metric_youtubes, :sgsn_name, :string
    add_column :metric_youtubes, :lat, :float
    add_column :metric_youtubes, :lon, :float
    add_column :metric_youtubes, :cell_id, :string
    add_column :metric_youtubes, :lac, :string
    add_column :metric_youtubes, :avg_rssi, :float
    add_column :metric_youtubes, :avg_rxlev, :float
    add_column :metric_youtubes, :avg_ecio, :float
  end
end

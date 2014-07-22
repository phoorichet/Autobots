class CreateMetricSpeedtests < ActiveRecord::Migration
  def change
    create_table :metric_speedtests do |t|
      t.string :region
      t.string :location
      t.string :rncname
      t.string :mobile_code
      t.string :imei
      t.string :imsi
      t.string :script_name
      t.string :set_server_name
      t.integer :attempt
      t.integer :download_1mbps
      t.float :speedtest_dl_1m_rate
      t.integer :download_2mbps
      t.float :speedtest_dl_2m_rate
      t.integer :upload_300kbps
      t.float :speedtest_ul_300k_rate
      t.integer :upload_1mkbps
      t.float :speedtest_ul_1m_rate
      t.integer :latency_300ms
      t.float :speedtest_lt_300k_rate

      t.timestamps
    end
  end
end

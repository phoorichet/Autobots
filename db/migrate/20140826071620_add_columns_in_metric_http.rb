class AddColumnsInMetricHttp < ActiveRecord::Migration
  def change
    add_column :metric_https, :sgsn_name, :string
    add_column :metric_https, :site, :string
    add_column :metric_https, :cell_id, :string
    add_column :metric_https, :lac, :string
    add_column :metric_https, :ip, :string
    add_column :metric_https, :lat, :float
    add_column :metric_https, :lon, :float
    add_column :metric_https, :connecting_time, :float
    add_column :metric_https, :avg_rssi, :float
    add_column :metric_https, :avg_rxlev, :float
    add_column :metric_https, :avg_ecio, :float
    add_column :metric_https, :throughput_download_app, :float
    add_column :metric_https, :throughput_download_rlc, :float
  end
end

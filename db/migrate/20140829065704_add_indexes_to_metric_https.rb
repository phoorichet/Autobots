class AddIndexesToMetricHttps < ActiveRecord::Migration
  def change
    add_index :metric_https, :serviceinfo
    add_index :metric_https, :sgsn_name
    add_index :metric_https, :apn
    add_index :metric_https, :date_time
  end
end

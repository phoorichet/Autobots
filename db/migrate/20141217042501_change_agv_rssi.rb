class ChangeAgvRssi < ActiveRecord::Migration
  def change
    rename_column :raw_https, :agv_rssi, :avg_rssi
  end
end

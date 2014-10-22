class CreateRawHttps < ActiveRecord::Migration
  def change
    create_table :raw_https do |t|
      t.float :connecting_time_1
      t.float :time_to_first_byte_1
      t.string :result_1
      t.string :result_detail_1
      t.string :imei
      t.string :imsi
      t.string :script_name
      t.string :service
      t.string :service_info
      t.float :agv_rssi
      t.float :avg_rxlev
      t.float :avg_ecio
      t.integer :cell_id
      t.integer :lac
      t.timestamp :start_date
      t.timestamp :stop_date
      t.float :duration_time
      t.integer :data_download_transfer
      t.float :max_download
      t.float :max_download_overall
      t.float :min_download
      t.float :throughput_download_ip
      t.float :throughput_download_app
      t.float :throughput_download_rlc
      t.string :result
      t.float :lat
      t.float :lon
      t.string :apn

      t.timestamps
    end
  end
end

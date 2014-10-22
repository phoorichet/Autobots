class CreateRawYoutubes < ActiveRecord::Migration
  def change
    create_table :raw_youtubes do |t|
      t.string :imei
      t.string :imsi
      t.string :script_name
      t.string :operator
      t.string :technology
      t.float :avg_rssi
      t.float :avg_rxlen
      t.float :avg_ecio
      t.integer :cell_id
      t.integer :lac
      t.datetime :start_time
      t.datetime :stop_time
      t.float :duration_time
      t.integer :data_download_transfer
      t.float :throughput_download_app
      t.float :throughput_download_rlc
      t.string :result
      t.string :result_detail
      t.integer :youtube_video_duration
      t.float :lat
      t.float :lon
      t.string :apn

      t.timestamps
    end
  end
end

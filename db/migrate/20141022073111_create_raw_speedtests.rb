class CreateRawSpeedtests < ActiveRecord::Migration
  def change
    create_table :raw_speedtests do |t|
      t.string :imei
      t.string :imsi
      t.string :technology
      t.datetime :datetime
      t.float :download
      t.float :upload
      t.integer :latency
      t.integer :server_id
      t.string :server_name
      t.float :avg_ecio
      t.float :avg_rssi
      t.integer :mcc
      t.integer :mcc
      t.integer :lac
      t.integer :cell_id
      t.string :script_name
      t.string :operator
      t.string :result
      t.integer :set_server_id
      t.string :set_server_name
      t.string :apn

      t.timestamps
    end
  end
end

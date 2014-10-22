class CreateRawPings < ActiveRecord::Migration
  def change
    create_table :raw_pings do |t|
      t.string :imei
      t.string :imsi
      t.string :technology
      t.datetime :datetime
      t.integer :packet_sent
      t.integer :packet_received
      t.integer :packet_lost
      t.float :rtt_min
      t.float :rtt_max
      t.float :rtt_mdev
      t.string :apn
      t.integer :apn_mcc
      t.integer :apn_mnc
      t.string :ip
      t.integer :lac
      t.integer :cell_id
      t.string :script_name
      t.integer :packet_size

      t.timestamps
    end
  end
end

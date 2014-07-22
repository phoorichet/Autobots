class CreateMetricPings < ActiveRecord::Migration
  def change
    create_table :metric_pings do |t|
      t.string :region
      t.string :location
      t.string :rncname
      t.string :mobile_code
      t.string :imei
      t.string :imsi
      t.string :target_ip
      t.integer :attempt
      t.float :percent_loss
      t.float :avg_packet_loss_rate
      t.float :avg_rtt_succ_rate

      t.timestamps
    end
  end
end

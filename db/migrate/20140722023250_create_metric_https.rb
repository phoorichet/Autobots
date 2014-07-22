class CreateMetricHttps < ActiveRecord::Migration
  def change
    create_table :metric_https do |t|
      t.string :region
      t.string :location
      t.string :rncname
      t.string :mobile_code
      t.string :imei
      t.string :imsi
      t.string :script_name
      t.string :apn
      t.string :serviceinfo
      t.integer :attempt
      t.integer :success
      t.float :http_succ_rate

      t.timestamps
    end
  end
end

class CreateMetricYoutubes < ActiveRecord::Migration
  def change
    create_table :metric_youtubes do |t|
      t.string :region
      t.string :location
      t.string :rncname
      t.string :mobile_code
      t.string :imei
      t.string :imsi
      t.string :script_name
      t.integer :attempt
      t.integer :success
      t.integer :quality
      t.float :youtube_succ_rate
      t.float :youtube_qual_rate
      t.float :youtube_rate

      t.timestamps
    end
  end
end

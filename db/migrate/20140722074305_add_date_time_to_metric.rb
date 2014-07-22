class AddDateTimeToMetric < ActiveRecord::Migration
  def change
    add_column :metric_https, :date_time, :datetime
    add_column :metric_pings, :date_time, :datetime
    add_column :metric_speedtests, :date_time, :datetime
    add_column :metric_youtubes, :date_time, :datetime
  end
end

class ChangeDateColumnRawHttp < ActiveRecord::Migration
  def change
    rename_column :raw_https, :start_date, :start_time
    rename_column :raw_https, :stop_date, :stop_time
  end
end

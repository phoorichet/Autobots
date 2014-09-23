class AddIntervalToTimeconfig < ActiveRecord::Migration
  def change
    add_column :time_configs, :interval, :integer
  end
end

class AddStopToTimeConfig < ActiveRecord::Migration
  def change
    add_column :time_configs, :stop, :string
    rename_column :time_configs, :reps, :start
  end
end

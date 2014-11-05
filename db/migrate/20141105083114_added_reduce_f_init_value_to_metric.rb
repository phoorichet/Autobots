class AddedReduceFInitValueToMetric < ActiveRecord::Migration
  def change
    add_column :metrics, :reducef_init_value, :string
  end
end

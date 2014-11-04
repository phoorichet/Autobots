class AddMapReduceToMetric < ActiveRecord::Migration
  def change
    add_column :metrics, :mapf, :string
    add_column :metrics, :reducef, :string
  end
end

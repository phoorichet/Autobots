class AddMetricVizRelation < ActiveRecord::Migration
  def change
    add_column :metrics, :visualization_id, :integer
  end
end

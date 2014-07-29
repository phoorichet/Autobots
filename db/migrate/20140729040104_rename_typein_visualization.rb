class RenameTypeinVisualization < ActiveRecord::Migration
  def change
    rename_column :visualizations, :type, :type_viz
  end
end

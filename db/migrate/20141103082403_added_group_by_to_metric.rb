class AddedGroupByToMetric < ActiveRecord::Migration
  def change
    add_column :metrics, :groupf, :string
  end
end

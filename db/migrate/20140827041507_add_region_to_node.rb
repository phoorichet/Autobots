class AddRegionToNode < ActiveRecord::Migration
  def change
    add_column :nodes, :coverage_region, :string
    add_column :nodes, :site, :string
  end
end

class RenameAvgRxlenToAvgRxlev < ActiveRecord::Migration
  def change
    rename_column :raw_youtubes, :avg_rxlen, :avg_rxlev
  end
end

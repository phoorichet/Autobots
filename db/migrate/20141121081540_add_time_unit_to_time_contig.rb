class AddTimeUnitToTimeContig < ActiveRecord::Migration
  def change
    add_column :time_configs, :time_unit, :string
  end
end

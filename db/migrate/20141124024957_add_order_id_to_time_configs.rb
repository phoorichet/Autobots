class AddOrderIdToTimeConfigs < ActiveRecord::Migration
  def change
    add_column :time_configs, :order_id, :integer
  end
end

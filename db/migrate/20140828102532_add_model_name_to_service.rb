class AddModelNameToService < ActiveRecord::Migration
  def change
    add_column :services, :model_name, :string
    remove_column :metrics, :model_name
  end
end

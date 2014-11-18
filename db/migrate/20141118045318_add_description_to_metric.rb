class AddDescriptionToMetric < ActiveRecord::Migration
  def change
    add_column :metrics, :description, :string
  end
end

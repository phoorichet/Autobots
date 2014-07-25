class CreateMetrics < ActiveRecord::Migration
  def change
    create_table :metrics do |t|
      t.string :name
      t.string :settings
      t.string :model_name
      t.string :attr
      t.string :transform
      t.integer :service_id

      t.timestamps
    end
  end
end

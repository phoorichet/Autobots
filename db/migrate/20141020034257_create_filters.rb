class CreateFilters < ActiveRecord::Migration
  def change
    create_table :filters do |t|
      t.string :name
      t.string :description
      t.boolean :multiple
      t.string :data
      t.integer :metric_id

      t.timestamps
    end
  end
end

class CreateSelectfs < ActiveRecord::Migration
  def change
    create_table :selectfs do |t|
      t.string :field
      t.boolean :selected
      t.integer :metric_id

      t.timestamps
    end
  end
end

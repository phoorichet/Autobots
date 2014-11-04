class CreateVspecs < ActiveRecord::Migration
  def change
    create_table :vspecs do |t|
      t.string :name
      t.string :value
      t.integer :metric_id

      t.timestamps
    end
  end
end

class CreateNodes < ActiveRecord::Migration
  def change
    create_table :nodes do |t|
      t.string :name
      t.string :node_type
      t.string :status

      t.timestamps
    end
  end
end

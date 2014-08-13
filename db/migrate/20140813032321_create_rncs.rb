class CreateRncs < ActiveRecord::Migration
  def change
    create_table :rncs do |t|
      t.string :name
      t.integer :sgsn_id

      t.timestamps
    end
  end
end

class CreateMsLocations < ActiveRecord::Migration
  def change
    create_table :ms_locations do |t|
      t.string :mobile_code
      t.integer :mini_box
      t.string :imei
      t.string :serial_no
      t.string :mobile_no
      t.string :region
      t.string :rncname
      t.string :building_id
      t.string :location

      t.timestamps
    end
  end
end

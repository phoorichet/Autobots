class CreateSgsns < ActiveRecord::Migration
  def change
    create_table :sgsns do |t|
      t.string :name

      t.timestamps
    end
  end
end

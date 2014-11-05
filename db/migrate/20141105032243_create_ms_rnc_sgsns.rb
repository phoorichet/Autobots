class CreateMsRncSgsns < ActiveRecord::Migration
  def change
    create_table :ms_rnc_sgsns do |t|
      t.string :rnc_name
      t.string :sgsn_name

      t.timestamps
    end
  end
end

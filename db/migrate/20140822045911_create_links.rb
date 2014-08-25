class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.string :source
      t.string :target
      t.string :status

      t.timestamps
    end
  end
end

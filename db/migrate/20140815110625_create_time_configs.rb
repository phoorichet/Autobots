class CreateTimeConfigs < ActiveRecord::Migration
  def change
    create_table :time_configs do |t|
      t.string :name
      t.string :description
      t.string :reps
      t.string :time_type

      t.timestamps
    end
  end
end

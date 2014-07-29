class CreateVisualizations < ActiveRecord::Migration
  def change
    create_table :visualizations do |t|
      t.string :name
      t.string :view_path
      t.string :setting
      t.string :type
      t.string :config_file

      t.timestamps
    end
  end
end

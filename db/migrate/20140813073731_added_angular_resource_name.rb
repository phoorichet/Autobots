class AddedAngularResourceName < ActiveRecord::Migration
  def change
    # resource_name is mapped to resouce service in AngularJs
    add_column :metrics, :resource_name, :string 
  end
end

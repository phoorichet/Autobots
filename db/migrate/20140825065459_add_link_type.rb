class AddLinkType < ActiveRecord::Migration
  def change
    add_column :links, :link_type, :string
  end
end

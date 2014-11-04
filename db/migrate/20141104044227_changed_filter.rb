class ChangedFilter < ActiveRecord::Migration
  def change

    add_column :filters, :operand, :string
    add_column :filters, :operation, :string
    add_column :filters, :field, :string

    remove_column :filters, :data
    remove_column :filters, :name
    remove_column :filters, :multiple

  end
end

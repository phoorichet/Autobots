class AddOperandTypeToFilter < ActiveRecord::Migration
  def change
    add_column :filters, :operand_type, :string
  end
end

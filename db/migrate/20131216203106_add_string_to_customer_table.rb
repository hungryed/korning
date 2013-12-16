class AddStringToCustomerTable < ActiveRecord::Migration
  def up
    add_column :customers, :string, :string
  end

  def down
    remove_column :customers, :string
  end
end

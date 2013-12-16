class AddStringToEmployee < ActiveRecord::Migration
  def up
    add_column :employees, :string, :string
  end

  def down
    remove_column :employees, :string
  end
end

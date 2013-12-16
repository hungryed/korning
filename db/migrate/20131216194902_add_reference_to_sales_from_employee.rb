class AddReferenceToSalesFromEmployee < ActiveRecord::Migration
  def up
    change_table :sales do |t|
      t.references :employee
    end
    Sale.all.each do |sale|
      employee = sale.employee
      id = Employee.where(string: employee).first.id
      sale.update_attributes(
        employee_id: id)
    end
    remove_column :sales, :employee
  end

  def down
    add_column :sales, :employee, :string
    Sale.all.each do |sale|
      id = sale.employee_id
      employee_string = Employee.find(id).string
      sale.update_attributes(
        employee: employee_string)
    end
    remove_column :sales, :employee_id
  end
end

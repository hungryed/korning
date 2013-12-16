class AddCustomerReferenceToSales < ActiveRecord::Migration
  def up
    change_table :sales do |t|
      t.references :customer
    end
    Sale.all.each do |sale|
      customer = sale.customer_and_account_no
      id = Customer.where(string: customer).first.id
      sale.update_attributes(
        customer_id: id)
    end
    remove_column :sales, :customer_and_account_no
  end

  def down
    add_column :sales, :customer_and_account_no, :string
    Sale.all.each do |sale|
      id = sale.customer_id
      customer_string = Customer.find(id).string
      sale.update_attributes(
        customer_and_account_no: customer_string)
    end
    remove_column :sales, :customer_id
  end
end

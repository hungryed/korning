require 'csv'
require 'pry'

datafile = Rails.root + 'db/data/sales.csv'

# CSV.foreach(datafile, headers: true) do |row|
#   sale_amount = row['sale_amount'].tr('$', '')
#   Sale.find_or_create_by(invoice_no: row['invoice_no']) do |sale|
#     sale.employee = row['employee']
#     sale.customer_and_account_no = row['customer_and_account_no']
#     sale.product_name = row['product_name']
#     sale.sale_date = row['sale_date']
#     sale.sale_amount = sale_amount
#     sale.units_sold = row['units_sold']
#     sale.invoice_no = row['invoice_no']
#     sale.invoice_frequency = row['invoice_frequency']

#     puts "Sale with invoice no. #{sale.invoice_no} processed"
#   end
# end
read_sales = SalesReader.new(datafile)
read_sales.read_file
read_sales.get_individual_stats
read_sales.find_duplicate_invoice_numbers
read_sales.find_duplicate_sale_invoices
read_sales.remove_good_invoices
read_sales.reassign_invoice_numbers

sales = read_sales.data

read_sales.employees.each do |employee_string|
  employee_hash = Employee.get_employee_hash(employee_string)
  first_name = employee_hash[:first_name]
  last_name = employee_hash[:last_name]
  Employee.find_or_create_by(first_name: first_name, last_name: last_name) do |employee|
    employee.first_name = employee_hash[:first_name]
    employee.last_name = employee_hash[:last_name]
    employee.email = employee_hash[:email]
  end
end

read_sales.clients.each do |customer_string|
  customer_data = Customer.get_customer_data(customer_string)
  Customer.find_or_create_by(account_number: customer_data[:account_number]) do |company|
    company.name = customer_data[:name]
    company.account_number = customer_data[:account_number]
  end
end

read_sales.products.each do |product|
  # product.split.map(&:capitalize).join(" ")
  product_description = Product.get_product_info(product)
  Product.find_or_create_by(name: product_description[:name]) do |product|
    product.name = product_description[:name]
  end
end

binding.pry

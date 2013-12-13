require 'csv'
require 'pry'

datafile = Rails.root + 'db/data/sales.csv'

CSV.foreach(datafile, headers: true) do |row|
  sale_amount = row['sale_amount'].tr('$', '')
  Sale.find_or_create_by(invoice_no: row['invoice_no']) do |sale|
    sale.employee = row['employee']
    sale.customer_and_account_no = row['customer_and_account_no']
    sale.product_name = row['product_name']
    sale.sale_date = row['sale_date']
    sale.sale_amount = sale_amount
    sale.units_sold = row['units_sold']
    sale.invoice_no = row['invoice_no']
    sale.invoice_frequency = row['invoice_frequency']

    puts "Sale with invoice no. #{sale.invoice_no} processed"
  end
end

employees = []
products = []
frequency = []
Sale.all.each do |sale|
  employees << sale.employee
  products << sale.product_name
  frequency << sale.invoice_frequency
end
employees.uniq!
products.uniq!
frequency.uniq!
binding.pry

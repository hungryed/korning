class SalesReader
  attr_reader :data, :employees, :clients, :products, :frequency

  def initialize(filename)
    @filename = filename
    @data = []
  end

  def read_file
    CSV.foreach(@filename, headers: true) do |row|
      whole_sale = {}
      sale_amount = row['sale_amount'].tr('$', '').to_f
      whole_sale[:employee] = row['employee']
      whole_sale[:customer_and_account_no] = row['customer_and_account_no']
      whole_sale[:product_name] = row['product_name']
      whole_sale[:sale_date] = row['sale_date']
      whole_sale[:sale_amount] = sale_amount
      whole_sale[:units_sold] = row['units_sold'].to_i
      whole_sale[:invoice_no] = row['invoice_no']
      whole_sale[:invoice_frequency] = row['invoice_frequency']
      whole_sale[:price_per_unit] = (sale_amount / row['units_sold'].to_i).round(2)
      puts "Sale with invoice no. #{row['invoice_no']} processed"
      @data << whole_sale
    end
  end

  def get_individual_stats
    @employees, @products, @frequency, @invoice_numbers = [], [], [], []
    @clients = []
    @data.each do |sale|
      @employees << sale[:employee]
      @clients << sale[:customer_and_account_no]
      @products << sale[:product_name]
      @frequency << sale[:invoice_frequency]
      @invoice_numbers << sale[:invoice_no]
    end
    @employees.uniq!
    @products.uniq!
    @frequency.uniq!
    @clients.uniq!
  end

  def find_duplicate_invoice_numbers
    @duplicate_invoice_numbers = @invoice_numbers.find_all do |number|
      @invoice_numbers.count(number) > 1
    end
    @duplicate_invoice_numbers.uniq!
  end

  def find_duplicate_sale_invoices
    @duplicate_invoices = data.find_all do |sale|
      @duplicate_invoice_numbers.include?(sale[:invoice_no])
    end
  end

  def remove_good_invoices
    @duplicate_invoice_numbers.length.times do
      bad_number = @duplicate_invoice_numbers.pop
      first_bad_invoice = @duplicate_invoices.find do |invoice|
        invoice[:invoice_no] == bad_number
      end
      @duplicate_invoices.delete(first_bad_invoice)
    end
  end

  def reassign_invoice_numbers
    @duplicate_invoices.each do |invoice|
      random_number = rand(9999..100000)
      while @invoice_numbers.include?(random_number)
        random_number = rand(9999..100000)
      end
      @data.delete(invoice)
      invoice[:invoice_no] = random_number
      @data << invoice
    end
  end
end

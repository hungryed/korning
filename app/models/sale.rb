class Sale < ActiveRecord::Base
  belongs_to :employee
  belongs_to :customer
  validates_numericality_of :sale_amount
  validates_numericality_of :units_sold
  validates_presence_of :invoice_frequency_id
  validates_presence_of :employee_id
  validates_uniqueness_of :invoice_no
  validates_length_of :invoice_no, is: 5
  validates_numericality_of :invoice_no
  validates_presence_of :product_id
  validates_presence_of :customer_id

  def last_3_months(data)
    data
  end
end

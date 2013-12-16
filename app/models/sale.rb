class Sale < ActiveRecord::Base
  belongs_to :employee
  belongs_to :customer

  def last_3_months(data)
    data
  end
end

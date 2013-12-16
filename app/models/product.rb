class Product < ActiveRecord::Base
  has_many :sales
  class << self
    def get_product_info(product)
      {name: product}
    end
  end
end

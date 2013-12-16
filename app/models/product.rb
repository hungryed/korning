class Product < ActiveRecord::Base

  class << self
    def get_product_info(product)
      {name: product}
    end
  end
end

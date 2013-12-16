class Customer < ActiveRecord::Base
  has_many :sales
  class << self
    def get_customer_data(string)
      string = remove_parenthesis(string)
      string = string.split
      {
        account_number: string.pop,
        name: string.join(" ")
      }
    end

    def remove_parenthesis(string)
      string.gsub(/[\(\)]/, '')
    end

  end
end

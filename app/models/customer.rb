class Customer < ActiveRecord::Base
  has_many :sales
  class << self
    def get_customer_data(string)
      formatted_string = remove_parenthesis(string)
      string_array = formatted_string.split
      {
        account_number: string_array.pop,
        name: string_array.join(" "),
        string: string
      }
    end

    def remove_parenthesis(string)
      string.gsub(/[\(\)]/, '')
    end

  end
end

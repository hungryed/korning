class Employee < ActiveRecord::Base

  class << self
    def get_employee_hash(string)
      string = remove_parenthesis(string)
      employee_info = divide_string(string)
      {
        email: employee_info.pop,
        last_name: employee_info.pop,
        first_name: employee_info[0],
      }
    end

    def remove_parenthesis(string)
      string.gsub(/[\(\)]/, '')
    end

    def divide_string(string)
      string.split
    end
  end
end

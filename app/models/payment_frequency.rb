class PaymentFrequency < ActiveRecord::Base
  FREQUENCY_MAP = {
    "Once" => 1,
    "Quarterly" => 3,
    "Monthly" => 12
  }

  class << self
    def get_frequency_info(frequency)
      payment_cycle = FREQUENCY_MAP[frequency] rescue nil
      {
        frequency: frequency,
        cycle: payment_cycle
      }
    end
  end
end

class CreatePaymentFrequencies < ActiveRecord::Migration
  def change
    create_table :payment_frequencies do |t|
      t.string :rate
      t.integer :invoice_bills

      t.timestamps
    end
  end
end

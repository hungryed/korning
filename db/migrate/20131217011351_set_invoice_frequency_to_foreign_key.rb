class SetInvoiceFrequencyToForeignKey < ActiveRecord::Migration
  def up
    change_table :sales do |t|
      t.references :invoice_frequency
    end
    Sale.all.each do |sale|
      payment = sale.invoice_frequency
      id = PaymentFrequency.where(rate: payment).first.id
      sale.update_attributes(
        invoice_frequency_id: id)
    end
    remove_column :sales, :invoice_frequency
  end

  def down
    add_column :sales, :invoice_frequency, :string
    Sale.all.each do |sale|
      id = sale.invoice_frequency_id
      payment_string = PaymentFrequency.find(id).rate
      sale.update_attributes(
        invoice_frequency: payment_string)
    end
    remove_column :sales, :invoice_frequency_id
  end
end

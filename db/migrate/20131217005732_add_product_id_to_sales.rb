class AddProductIdToSales < ActiveRecord::Migration
  def up
    change_table :sales do |t|
      t.references :product
    end
    Sale.all.each do |sale|
      product = sale.product_name
      id = Product.where(name: product).first.id
      sale.update_attributes(
        product_id: id)
    end
    remove_column :sales, :product_name
  end

  def down
    add_column :sales, :product_name, :string
    Sale.all.each do |sale|
      id = sale.product_id
      product_string = Product.find(id).name
      sale.update_attributes(
        product_name: product_string)
    end
    remove_column :sales, :product_id
  end
end

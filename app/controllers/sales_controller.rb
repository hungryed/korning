class SalesController < ApplicationController
  def index
    @sales = Sale.all
  end

  def new
    @sale = Sale.new
  end

  def create
    @sale = Sale.new(sales_params)

    if @sale.save
      redirect_to sales_path
    else
      render :new
    end
  end

  def sales_params
    params.require(:sale).permit(:sale_amount, :units_sold, :invoice_frequency_id,
      :employee_id, :product_id, :customer_id, :invoice_no)
  end
end

class OrderLinesController < ApplicationController
  def create
    @order_line = create_order_line

    if @order_line.valid?
      render json: @order_line, status: :created, location: @order_line
    else
      render json: @order_line.errors, status: :unprocessable_entity
    end
  end
  
  private
  
  def create_order_line
    order_line = OrderLine.new(order_line_params)
    # TODO look for existing order line if order exists and amend it if it has the same product
    # or alternatively, show on the page that product is already added if it has the same size, and allow the user to amend the quantity
    ensure_order_created!
    order_line.order_id = session[:order_id]
    order_line.save if order_line.changed?
    order_line
  end
  
  def order_line_params
    params.require(:order_line).permit(:product_id, :size, :quantity)
  end
end

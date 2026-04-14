class OrderLinesController < ApplicationController
  def create
    @order_line = create_order_line

    if @order_line.valid?
      render json: @order_line, status: :created, location: @order_line
    else
      render json: @order_line.errors, status: :unprocessable_entity
    end
  end
  
  def destroy
    @order_line = OrderLine.find(params[:id])
    @order_line.destroy!

    respond_to do |format|
      format.html { redirect_to products_path, notice: "Order line was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end
  
  private
  
  def create_order_line
    order_line = OrderLine.new(order_line_params)
    ensure_order_created!
    order_line.order_id = session[:order_id]
    order_line.save if order_line.changed?
    order_line
  end
  
  def order_line_params
    params.require(:order_line).permit(:product_id, :size, :quantity)
  end
end

class OrdersController < ApplicationController
  before_action :set_order, only: %i[ show edit update ]

  def show
  end
  
  def edit
  end
  
  def update
    # TODO update an order with shipping address, billing address, payment info, and finally placed=true to submit it (refreshing the shopping cart order if needed)
    # rely on accepts_nested_attributes_for inside Order
    respond_to do |format|
      if @order.update(order_params) # TODO implement order_params with nested attributes
        format.html { redirect_to @order, notice: "Order was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end
  
  private
  
  def set_order
    if params[:id] == 'shopping_cart'
      ensure_order_created!
      @order = Order.find(session[:order_id])
    else
      @order = Order.find(params[:id])
    end
  end
  
  def order_params
    params.require(:order).permit(
      shipping_address_attributes: [:id, :first_name, :last_name, :street, :city, :state_or_province, :zip_or_postal_code, :country, :phone, :email],
      billing_address_attributes: [:id, :first_name, :last_name, :street, :city, :state_or_province, :zip_or_postal_code, :country, :phone, :email],
      payment_info_attributes: [:id, :card_number, :expiry_date, :security_code],
    )
  end
end

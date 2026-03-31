class OrdersController < ApplicationController
  before_action :set_order, only: %i[ show ]

  def show
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
end

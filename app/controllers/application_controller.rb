class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  
  def ensure_order_created!
    if session[:order_id].blank?
      create_order!
    else
      order = Order.find(session[:order_id])
      create_order! if order.placed? # placed order must be replaced by a fresh order
    end
  end
  
  def create_order!
    order = Order.create!
    session[:order_id] = order.id
  end
end

class OrderLine < ApplicationRecord
  belongs_to :order
  belongs_to :product
  
  after_save :update_order_calculations!
  after_destroy :update_order_calculations!
  
  def subtotal
    product.price * quantity
  end
  
  private
  
  def update_order_calculations!
    order.update_calculations!
  end
end

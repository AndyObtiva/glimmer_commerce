module OrdersHelper
  def order_attributes
    OrderSerializer.new(@order).serializable_hash
  end
end

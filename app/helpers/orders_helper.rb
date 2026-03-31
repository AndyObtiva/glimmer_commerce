module OrdersHelper
  def order_attributes
    pd OrderSerializer.new(@order).serializable_hash
  end
end

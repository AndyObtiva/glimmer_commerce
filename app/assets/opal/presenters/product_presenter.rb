require 'rails/resource_service'

require 'models/product'
require 'models/order_line'

class ProductPresenter
  attr_accessor :product, :size, :quantity
  
  def initialize(product_attributes:, product:)
    @product = product_attributes ? Product.new(product_attributes) : product
    @size = 'M'
    @quantity = 1
  end
  
  def add_to_cart(&response_handler)
    order_line = OrderLine.new(product_id: @product.id, size: @size, quantity: @quantity)
    Rails::ResourceService.create(resource: order_line, &response_handler)
  end
end

require 'glimmer-dsl-web'

require 'models/product'
require 'models/order_line'
require 'models/order'
require 'views/product_info'

class ShoppingCart
  include Glimmer::Web::Component

  attribute :order_attributes
  attr_reader :order
  
  before_render do
    puts order_attributes
    @order = Order.new(order_attributes)
  end

  markup {
    div {
      @order.order_lines.each do |order_line|
        puts order_line.product
        product_info(product: order_line.product, product_info_only: true)
      end
    }
  }
end

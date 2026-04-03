require 'glimmer-dsl-web'

require 'models/product'
require 'models/order_line'
require 'models/order'
require 'views/order_summary'
require 'views/order_address'

class OrderCheckout
  include Glimmer::Web::Component

  attribute :order_attributes
  attr_reader :order
  
  before_render do
    @order = Order.new(order_attributes)
  end

  markup {
    div {
      h1 { 'Checkout' }
      order_summary(order:)
      order_address(order:, address_name: 'shipping')
      order_address(order:, address_name: 'billing')
#       payment_info(order:, editable_section_presenter:)
    }
  }
  
  style {
    r('.order-checkout') {
      width 1000
    }
  }
end

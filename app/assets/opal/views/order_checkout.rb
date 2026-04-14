require 'glimmer-dsl-web'

require 'models/order_line'
require 'models/order'
require 'views/order_summary'
require 'views/order_address_editable_section'
require 'views/payment_info_editable_section'

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
      order_address_editable_section(order:, address_name: 'shipping')
      order_address_editable_section(order:, address_name: 'billing')
      payment_info_editable_section(order:)
    }
  }
  
  style {
    r('.order-checkout') {
      width 1000
    }
  }
end

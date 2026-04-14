require 'glimmer-dsl-web'

require 'models/order'
require 'views/address_display'
require 'views/payment_display'

class OrderInfo
  include Glimmer::Web::Component
  
  attribute :order_attributes
  attr_reader :order
  
  before_render do
    @order = Order.new(order_attributes)
  end

  markup {
    div {
      address_display(address: order.billing_address)
      address_display(address: order.shipping_address)
      payment_display(payment_info: order.payment_info)
    
      div {
        p { 'Order Subtotal' }
        p { order.subtotal }
      }
      div {
        p { 'Shipping' }
        p { order.shipping }
      }
      div {
        p { 'Sales Tax' }
        p { order.sales_tax }
      }
      div {
        p { 'Order Total' }
        p { order.total }
      }
    }
  }
end

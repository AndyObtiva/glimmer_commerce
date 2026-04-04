require 'glimmer-dsl-web'

require 'models/order'

class OrderInfo
  include Glimmer::Web::Component
  
  attribute :order_attributes
  attr_reader :order
  
  before_render do
    @order = Order.new(order_attributes)
  end

  # TODO
  markup {
    div {
      p { 'Order Total' }
      p { order.total }
    }
  }
end

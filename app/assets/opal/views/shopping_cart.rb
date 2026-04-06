require 'glimmer-dsl-web'

require 'models/product'
require 'models/order_line'
require 'models/order'
require 'views/order_summary'
require 'views/product_info'

class ShoppingCart
  include Glimmer::Web::Component

  attribute :order_attributes
  attr_reader :order
  
  before_render do
    @order = Order.new(order_attributes)
  end

  markup {
    div {
      # TODO handle case of empty shopping cart
      order_summary(order:, checkout: true)
      div(class: 'cart') {
        h1 { 'Cart' }
        div(class: 'cart-products') {
          order.order_lines.each do |order_line|
            product_info(product: order_line.product, product_info_only: true)
          end
        }
      }
    }
  }
  
  style {
    r('.shopping-cart') {
      width 1000
    }
    r('.shopping-cart .cart h1') {
      padding_top 21
    }
    r('.shopping-cart .order-summary') {
      float 'right'
      width 600
    }
    r('.shopping-cart .order-summary table') {
      width 100.%
    }
    r('.shopping-cart .order-summary table tr td') {
      padding 5
    }
    r('.shopping-cart .order-summary .cart-checkout-button') {
      width 100.%
    }
  }
end

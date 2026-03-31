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
    @order = Order.new(order_attributes)
  end

  markup {
    div {
      h1 { 'Cart' }
      div(class: 'order-summary') {
        table {
          tr {
            td { 'Subtotal' }
            td { @order.subtotal }
          }
          tr {
            td { 'Shipping' }
            td { @order.shipping }
          }
          tr {
            td { 'Sales Tax' }
            td { @order.sales_tax }
          }
          tr {
            td { 'Total' }
            td { @order.total }
          }
        }
        button('Checkout', class: 'cart-checkout-button')
      }
      div(class: 'cart-products') {
        @order.order_lines.each do |order_line|
          product_info(product: order_line.product, product_info_only: true)
        end
      }
    }
  }
  
  style {
    r('.shopping-cart') {
      width 1000
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

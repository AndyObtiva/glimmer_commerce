require 'glimmer-dsl-web'

require 'models/product'
require 'models/order_line'
require 'models/order'
require 'presenters/order_line_presenter'
require 'views/order_summary'
require 'views/product_info'

class ShoppingCart
  include Glimmer::Web::Component

  attribute :order_attributes
  attr_reader :order, :order_line_presenter
  
  before_render do
    @order = Order.new(order_attributes)
    @order_line_presenter = OrderLinePresenter.new
  end

  markup {
    div {
      order_summary(order:, checkout: true)
      div(class: 'cart') {
        h1 { 'Cart' }
        div(class: 'cart-products') {
          content(order, :order_lines) {
            if order.order_lines.any?
              order.order_lines.each do |order_line|
                product_info(product: order_line.product, product_info_only: true) {
                  actions {
                    button('Remove') {
                      onclick do
                        order_line_presenter.remove_from_cart(order_line:, order:)
                      end
                    }
                  }
                }
              end
            else
              p {
                "There are no items in the shopping cart. #{a('Browse products.', href: '/')}"
              }
            end
          }
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
  }
end

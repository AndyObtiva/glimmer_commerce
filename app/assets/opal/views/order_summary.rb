require 'glimmer-dsl-web'

require 'models/order'

class OrderSummary
  include Glimmer::Web::Component

  attributes :order, :checkout

  markup {
    div(class: 'order-summary') {
      h1 { "Order Summary" }
      table {
        tr {
          td { 'Subtotal' }
          td { order.subtotal }
        }
        tr {
          td { 'Shipping' }
          td { order.shipping }
        }
        tr {
          td { 'Sales Tax' }
          td { order.sales_tax }
        }
        tr {
          td { 'Total' }
          td { order.total }
        }
      }
      if checkout && (order.total.to_i > 0)
        button('Checkout', class: 'cart-checkout-button') {
          onclick do
            $$.document.location.href = "/orders/#{order.id}/edit"
          end
        }
      end
    }
  }
  
  style {
    r('.order-summary') {
      position :fixed
      left 600
      top 42
      width 300
      padding 15
      border '2px solid black'
      border_radius 15
    }
    r('.order-summary table') {
      width 100.%
    }
    r('.order-summary table tr td') {
      padding 5
    }
    r('.order-summary .cart-checkout-button') {
      width 100.%
    }
  }
end
 

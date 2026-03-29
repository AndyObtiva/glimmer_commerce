require 'glimmer-dsl-web'

require 'models/product'
require 'presenters/product_presenter'
require 'views/product_size_selector'

class ProductInfo
  include Glimmer::Web::Component

  attribute :product_attributes
  attr_reader :presenter

  before_render do
    @presenter = ProductPresenter.new(product_attributes)
  end

  markup {
    div {
      div {
        h3 { presenter.product.brand }
        h1 { "#{presenter.product.name} - #{presenter.product.age} / #{presenter.product.gender}" }
        product_size_selector(presenter:)
        div {
          span(style: {margin_right: 5}) { 'Quantity:' }
          input(type: 'number', min: 1, max: 10) {
            value <=> [presenter, :quantity]
          }
        }
        h2 { "$#{presenter.product.price}" }
        button('Add to cart') {
          onclick do
            # TODO submit web request to add to cart
            # TODO do an animation that shows a product image shrinking and moving into the Shopping Cart icon in the top-right before updating the cart quantity badge
            # TODO Illuminate or bring attention to the shopping cart icon in the top-right
          end
        }
      }
      p {
        a(href: '/products') { 'Back' }
      }
    }
  }
end

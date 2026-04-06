require 'glimmer-dsl-web'

require 'models/product'
require 'presenters/product_presenter'
require 'views/product_size_selector'
require 'views/product_added_modal'

# TODO create a ProductOrderInfo or make this component take an option to hide add to cart part
class ProductInfo
  include Glimmer::Web::Component

  attributes :product_attributes, :product, :product_info_only
  attr_reader :presenter

  before_render do
    @presenter = ProductPresenter.new(product_attributes:, product:)
  end

  markup {
    div {
      div {
        h3 { presenter.product.brand }
        h1 { "#{presenter.product.name} - #{presenter.product.age} / #{presenter.product.gender}" }
        product_size_selector(presenter:, product_info_only:)
        div {
          span(style: {margin_right: 5}) { 'Quantity:' } # TODO show confirm button when changing it inside an order
          input(type: 'number', min: 1, max: 10) {
            value <=> [presenter, :quantity]
          }
        }
        h2 { "$#{presenter.product.price}" }
        unless product_info_only
          button('Add to cart') {
            onclick do
              @presenter.add_to_cart do
                ProductAddedModal.render
              end
              # TODO Illuminate or bring attention to the shopping cart icon in the top-right
            end
          }
          # TODO add Remove Button for Shopping Cart
          # Maybe use Glimmer Web Component Slots for that
        end
      }
      unless product_info_only
        p {
          a('Back', href: '/products')
        }
      end
    }
  }
end

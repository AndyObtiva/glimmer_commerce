require 'glimmer-dsl-web'

require 'models/product'
require 'presenters/product_presenter'
require 'views/product_size_selector'
require 'views/product_added_modal'
require 'views/product_list'

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
        h1 { "#{presenter.product.name} - #{presenter.product.age} / #{presenter.product.gender}" }
        h3 { presenter.product.brand }
        img(src: presenter.product.image_path, style: {width: 200})
        product_size_selector(presenter:, product_info_only:)
        unless product_info_only
          div {
            span(style: {margin_right: 5}) { 'Quantity:' }
            input(type: 'number', min: 1, max: 10) {
              value <=> [presenter, :quantity]
            }
          }
        end
        h2 { "$#{presenter.product.price}" }
        div(slot: :actions)
        unless product_info_only
          button('Add to cart') {
            onclick do
              @presenter.add_to_cart do
                ProductAddedModal.render
              end
            end
          }
        end
      }
      unless product_info_only
        div {
          page_component_link(text: 'Back to products', page_url: '/')
        }
      end
    }
  }
  
  style {
    r('.product-info .page-component-link') {
      display :block
      margin '10px 0'
    }
  }
end

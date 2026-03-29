require 'glimmer-dsl-web'

require 'models/product'
require 'presenters/product_presenter'

class ProductSizeSelector
  include Glimmer::Web::Component

  attribute :presenter

  markup {
    div {
      p {
        strong {
          inner_html <= [presenter, :size, on_read: -> { "Size: #{presenter.size}" }]
        }
      }
      ul(id: 'product-sizes') {
        Product::SIZES.each do |size|
          li(class: 'product-size') {
            button(size) {
              class_name('product-size-selected') <= [presenter, :size, on_read: ->(val) {val == size}]
              
              onclick do
                presenter.size = size
              end
            }
          }
        end
      }
    }
  }
  
  style {
    r('ul#product-sizes li.product-size') {
      display 'inline-block'
    }
    
    r('ul#product-sizes li.product-size button') {
      width 50
      margin 5
      border_radius 5
      background :white
    }
    
    r('ul#product-sizes li.product-size button.product-size-selected') {
      background :lightgrey
    }
  }
end

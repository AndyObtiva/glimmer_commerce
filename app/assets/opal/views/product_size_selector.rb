require 'glimmer-dsl-web'

require 'models/product'
require 'presenters/product_presenter'

class ProductSizeSelector
  include Glimmer::Web::Component

  attributes :presenter, :product_info_only

  markup {
    div {
      p {
        strong {
          inner_html <= [presenter, :size, on_read: -> { "Size: #{presenter.size}" }]
        }
      }
      unless product_info_only
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
      end
    }
  }
  
  style {
    r('ul#product-sizes') {
      padding 0
    }
    
    r('ul#product-sizes li.product-size') {
      display 'inline-block'
    }
    
    r('ul#product-sizes li.product-size button') {
      width 50
      margin 5
      border_radius 5
      background :white
      cursor :pointer
    }
    
    r('ul#product-sizes li.product-size button.product-size-selected') {
      background :black
      color :white
      cursor :initial
    }
  }
end

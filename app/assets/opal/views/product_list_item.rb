require 'glimmer-dsl-web'

require 'models/product'
require 'views/product_info'

class ProductListItem
  include Glimmer::Web::Component

  attribute :product
  attribute :presenter

  markup {
    li {
      page_component_link(component_class: ProductInfo, component_attributes: {product:}, page_url: product.resource_path) {
        img(src: product.image_path, style: {width: 200})
      }
      div {
        page_component_link(text: product.name, component_class: ProductInfo, component_attributes: {product:}, page_url: product.resource_path)
        span { " | #{product.brand} | #{product.gender} | #{product.age} | $#{product.price}" }
      }
    }
  }
  
  style {
    r('li.product-list-item') {
      flex '0 0 33.33333%'
      min_width 375
      max_width 'calc(33.33% - 40px)'
      margin 20
    }
    r('li.product-list-item img') {
      margin '10px 0'
    }
  }
end

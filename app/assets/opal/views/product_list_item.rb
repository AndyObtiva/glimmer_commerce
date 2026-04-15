require 'views/product_info'

class ProductListItem
  include Glimmer::Web::Component

  attribute :product
      
  markup {
    li {
      page_component_link(component_class: ProductInfo, component_attributes: {product_attributes: product.to_h}, page_url: product.resource_path) {
        img(src: product.image_path, width: 200)
      }
      div {
        page_component_link(text: product.name, component_class: ProductInfo, component_attributes: {product_attributes: product.to_h}, page_url: product.resource_path)
        span { " | #{product.brand} | #{product.gender} | #{product.age} | #{product.formatted_price}" }
      }
    }
  }
  
  style {
    rule('li.product-list-item') {
      flex '0 0 33.33333%'
      min_width '375px'
      max_width 'calc(33.33% - 20px)'
      margin '20px 10px'
    }
  }
end

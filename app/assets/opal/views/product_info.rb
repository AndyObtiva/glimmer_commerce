require 'glimmer-dsl-web'

require 'models/product'

class ProductInfo
  include Glimmer::Web::Component
  
  attribute :product_attributes
  attr_reader :product
  
  before_render do
    @product = Product.new(**product_attributes)
  end
  
  markup {
    div {
      h1 { "#{product.name} - #{product.age} / #{product.gender}" }
      h3 { product.brand }
      img(src: product.image_path, width: 200)
      h2 { product.formatted_price }
      p { product.description }
      div {
        page_component_link(text: 'Back to products', page_url: '/')
      }
    }
  }
end

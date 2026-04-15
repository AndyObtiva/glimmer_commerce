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
      h1 { product.name }
    }
  }
end

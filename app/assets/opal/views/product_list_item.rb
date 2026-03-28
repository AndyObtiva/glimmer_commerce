require 'glimmer-dsl-web'

require 'models/product'

class ProductListItem
  include Glimmer::Web::Component

  attribute :product
  attribute :presenter

  markup {
    li {
      "#{product.name} | $#{product.price}"
    }
  }
end

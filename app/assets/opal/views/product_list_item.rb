require 'glimmer-dsl-web'

require 'models/product'

class ProductListItem
  include Glimmer::Web::Component

  attribute :product
  attribute :presenter

  markup {
    li {
      a(href: product.resource_path) {
        product.name
      }
      span { " | $#{product.price}" }
    }
  }
end

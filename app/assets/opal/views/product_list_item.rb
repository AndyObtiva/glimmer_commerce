require 'glimmer-dsl-web'

require 'models/product'

class ProductListItem
  include Glimmer::Web::Component

  attribute :product
  attribute :presenter

  markup {
    li {
      # TODO navigate to product via Frontend, not Backend link (need to push the right URL in history)
      a(product.name, href: product.resource_path)
      span { " | $#{product.price}" }
    }
  }
end

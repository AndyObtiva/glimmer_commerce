require 'glimmer-dsl-web'

class ProductList
  include Glimmer::Web::Component

  attributes :products_attributes

  markup {
    div {
      h1 { 'Product List' }
      ul {
        products_attributes['products'].each do |product_attributes|
          li { product_attributes['name'] }
        end
      }
    }
  }
end

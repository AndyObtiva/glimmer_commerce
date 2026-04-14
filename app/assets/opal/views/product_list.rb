require 'glimmer-dsl-web'

class ProductList
  include Glimmer::Web::Component

  attributes :products_attributes

  markup {
    div {
      h1 { 'Product List' }
      ul(style: {'list-style-type': 'none', 'padding': '0'}) {
        products_attributes['products'].each do |product_attributes|
          li {
            img(src: product_attributes['image_path'], width: 200)
            div {
              "#{product_attributes['name']} | #{product_attributes['brand']} | #{product_attributes['gender']} | #{product_attributes['age']} | $#{'%.2f' % product_attributes['price']}"
            }
          }
        end
      }
    }
  }
end

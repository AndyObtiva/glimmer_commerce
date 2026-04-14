class ProductListItem
  include Glimmer::Web::Component

  attribute :product
      
  markup {
    li {
      img(src: product.image_path, width: 200)
      div {
        "#{product.name} | #{product.brand} | #{product.gender} | #{product.age} | #{product.formatted_price}"
      }
    }
  }
end

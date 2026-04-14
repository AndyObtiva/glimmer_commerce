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
  
  style {
    rule('li.product-list-item') {
      flex '0 0 33.33333%'
      min_width '375px'
      max_width 'calc(33.33% - 20px)'
      margin '20px 10px'
    }
  }
end

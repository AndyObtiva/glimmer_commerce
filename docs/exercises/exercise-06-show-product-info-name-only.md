# Exercise 6 Show Product Info (Name Only)

Feature: Navigate to a product from the product listing to see the product info (name only).

Topics: Glimmer HTML DSL, Glimmer Web Components, glimmer_component Rails Helper

Usecase:

- Visit http://localhost:3000/
- See a list of products
- Click on a product name or a product image to navigate to the product info page
- See the product name

Steps:

1. Implement a Glimmer Web Component that matches the component being rendered by `app/views/products/show.html.erb` with a `div` element as the markup root and an `h1` underneath it that has the product name
2. Make product names links that take the user to the Product Show page (`/products/product_id`)
3. Make product images links that take the user to the Product Show page (`/products/product_id`)

Tips:

- glimmer_component's first argument is the Opal path to the component being rendered and its second argument is the attributes being passed to the component, which should declare them under the same names
- Note that entry-point components that are rendered via glimmer_component must always include `require 'glimmer-dsl-web'` at the top of the file
- The product info component should convert the product attributes it receives into a `Product` Model that is stored inside an instance variable in a `before_render do end` block
- Links can be rendered using the anchor tag and if you read `app/serializers/product_serializer.rb` and `app/helpers/products_helper.rb`, you will notice it includes a `resource_path` in `product_attributes` that you can use as the `href` property of the `a` element.
- If you want to make only the product name a link, you need to remove it from the product `String` and make it its own `a` element ahead of the product `String` in addition to wrapping the remainder of the product `String ` in a span too (so, its parent `div` ends up containing an `a` and a `span`).
- To make an image a link, you need to wrap it with an anchor tag as well

Solution:

`app/assets/opal/views/product_info.rb`:
```ruby
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
```

`app/assets/opal/views/product_list_item.rb`:
```ruby
class ProductListItem
  include Glimmer::Web::Component

  attribute :product
      
  markup {
    li {
      a(href: product.resource_path) {
        img(src: product.image_path, width: 200)
      }
      div {
        a(href: product.resource_path) { product.name }
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
```

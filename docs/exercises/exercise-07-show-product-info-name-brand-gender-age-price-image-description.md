# Exercise 7 Show Product Info (Name, Brand, Gender, Age, Price, Image, and Description)

Feature: Navigate to a product from the product listing to see the product info with name, brand, gender, age, price, image, and description.

Topics: Glimmer HTML DSL, Glimmer Web Components, glimmer_component Rails Helper

Usecase:

- Visit http://localhost:3000/
- See a list of products
- Click on a product name or a product image to navigate to the product info page
- See the product name, brand, gender, age, price, image, and description.

Steps:

1- Update the `ProductInfo` Glimmer Web Component to include brand, gender, age, price, image, and description following this HTML that a web designer provided:

```html
<div>
  <h1>Product Name - Adult / Female</h1>
  <h3>Mirage</h3>
  <img src="/images/t-shirts/t-shirt-navy-blue.svg" width=200>
  <h2>$68.12</h2>
  <p>This is the product description.</p>
</div>
```

Tips:

- You can optionally use the `html_to_glimmer` command to convert the HTML automatically to Glimmer HTML DSL syntax
- Notice that the age (Adult) and gender (female) are added to the first `h1` in `ProductInfo` after the name (can be interpolated into the same Ruby `String`)
- `p` renders the paragraph tag within the context of the Glimmer HTML DSL, unlike the behavior of `p` in general Ruby, which is to print inspected objects. Glimmer DSL for Web automatically adjusts its behavior inside the Glimmer HTML DSL markup code while keeping its original behavior outside of there. That enables Web Developers to conveniently render a `p` tag when needed.

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
      h1 { "#{product.name} - #{product.age} / #{product.gender}" }
      h3 { product.brand }
      img(src: product.image_path, width: 200)
      h2 { product.formatted_price }
      p { product.description }
    }
  }
end
```

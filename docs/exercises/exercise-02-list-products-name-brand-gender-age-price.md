# Exercise 2 List Products (Name, Brand, Gender, Age, and Price)

Feature: See a list of products with name, brand, gender, age, and price on the home page.

Topics: Glimmer HTML DSL, Glimmer Web Components

Usecase:

- Visit http://localhost:3000/
- See a list of products with name, brand, gender, age, and price following the format `Name | Brand | Gender | Age | $Price-with-2-decimals`

Steps:

1- Update content of `li` elements under the product `ul` list to render a Ruby string that interpolates name, brand, gender, age, and price with the format `Name | Brand | Gender | Age | $Price-with-2-decimals`

Tips:

- The `ProductList` `products_attributes` `products` array of hashes contains all necessary product fields
- You can format a numeric `String` to have 2 decimals with `'%.2f' % value`

Solution:

`app/assets/opal/views/product_list.rb`:

```ruby
require 'glimmer-dsl-web'

class ProductList
  include Glimmer::Web::Component

  attributes :products_attributes

  markup {
    div {
      h1 { 'Product List' }
      ul {
        products_attributes['products'].each do |product_attributes|
          li { "#{product_attributes['name']} | #{product_attributes['brand']} | #{product_attributes['gender']} | #{product_attributes['age']} | $#{'%.2f' % product_attributes['price']}" }
        end
      }
    }
  }
end
```

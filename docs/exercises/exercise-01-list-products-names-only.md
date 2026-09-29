# Exercise 1 List Products (Names Only)

Feature: See a list of product names on the home page.

Topics: Glimmer HTML DSL, Glimmer Web Components

Usecase:

- Visit http://localhost:3000/
- See a list of product names

Steps:

1. Clear the markup of `app/assets/opal/views/product_list.rb`
2. Add a root `div` and an `h1` inside its block with the text "Product List"
3. Below the `h1`, add a `ul` HTML list with `li` elements containing product names

Tips:

- Rails routes link the root URL (homepage) to the Products Index route, which renders the Glimmer Component `app/assets/opal/views/product_list.rb` with the `products_attributes` argument
- The `ProductList` `products_attributes` contains an array of hashes representing products (attributes) under the `products` root key.
- Everything that is curerntly displaying on the homepage of the Rails web app needs to be deleted and replaced.
- You can iterate over the `products_attributes` `products` value with an `each` statement inside the `markup {}` of `ProductList`

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
          li { product_attributes['name'] }
        end
      }
    }
  }
end
```

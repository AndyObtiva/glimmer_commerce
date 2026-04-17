# Exercise 3 List Products (Name, Brand, Gender, Age, Price, and Image)

Feature: See a list of products with name, brand, gender, age, price, and image on the home page.

Topics: Glimmer HTML DSL, Glimmer Web Components

Usecase:

- Visit http://localhost:3000/
- See a list of products with name, brand, gender, age, price, and image

Steps:

1. Inside each product's `li` element, surround the product `String` by a `div` to prepare for adding an image above it inside the same `li`
2. Include an `img` element in each product's `li` element above the product `String` `div`
3. Set the `img` element `width` attribute to `200`
4. Hide list bullet points
5. Remove the indentation of the list

Tips:

- The product hash inside `ProductList` `products_attributes` `products` contains `image_path`
- The HTML DSL supports using the HTML `img` tag (e.g. `img(src: '/someimage.png', width: 300)`)
- You can change the style of an element directly by including a `style` argument with the value being a hash of CSS styles (e.g. `style: {'background-color': 'red'}`)
- To hide list bullet points, you can set the `ul` `list-style-type` CSS property to `none`
- To remove the indentation of the list, you can set the `ul` `padding` CSS property to `0`

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
```

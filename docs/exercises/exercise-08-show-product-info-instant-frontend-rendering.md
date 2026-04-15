# Exercise 8 Show Product Info (Instant Frontend Rendering and Back To Products Link)

Feature: Navigate to a product from the product listing instantly without a website hit, and navigate instantly back to the product listing home page.

Topics: Glimmer HTML DSL, Page Component Link

Usecase:

- Visit http://localhost:3000/
- See a list of products
- Click on a product name or a product image to navigate to the product info page instantly without a website hit
- See the product name, brand, gender, age, price, image, and description, plus a link to go back to the product listing
- Click the link to go back to products in the home page and see the list of products again

Steps:

1- Enhance the anchor tags in the product list homepage by replacing `a` elements with `page_component_link` (built-in Glimmer Web Component), to enable instant rendering of the product page when navigating to a product given that the product list page has all the product data attributes anyways
2- Add a "Back to products" link at the bottom of the product page (inside its own `div`) using `page_component_link` as well.

Tips:

- `page_component_link` enables instant rendering of a page component (e.g. `ProductInfo`) by providing it with all the attributes it needs and specifying a page URL to make the navigation shareable and bookmarkable (plus supporting the Browser back/forward buttons) by updating the browser address bar (automatically pushing a URL into the JS Browser History). This enables providing users with instant Frontend rendering response time when the page already contains all the data needed for the page that needs to be navigated to (e.g. `ProductList` already has the attributes of all the products it displays, so it can pass them to `ProductInfo` via `page_component_link`). This is a new Glimmer DSL for Web feature that overcomes weaknesses in many JS libraries by providing a very simple way to provide deep linking in a Single Page Application.
- `page_component_link` takes the keyword arguments `text`, `component_class`, `component_attributes` (hash of component attributes), and `page_url` (e.g. `page_component_link(text: user.email, component_class: UserInfo, component_attributes: {user:}, page_url: user.account_url)`)
- `page_component_link` needs to be used to `ProductListItem` in place of `a` elements to enable instant navigation into product info pages
- Make sure to add `require 'views/product_info'` to be able to reference the `ProductInfo` class when passing it as the `component_class` keyword argument to `page_component_link`
- You can configure a `Product` `Struct` back into its attributes via `to_h` method to pass it as the `component_attributes` keyword argument to `page_component_link` (or alternatively, update the `ProductInfo` component to optionally accept a `product` attribute directly if available in place of `product_attributes`, adding internal logic inside `before_render` to handle both cases)
- `page_component_link` supports wrapping an `img` as well by leaving the `text` keyword argument off and opening a block that wraps the `img` element that needs to become a page component link
- `page_component_link` can be used at the bottom of the `ProductInfo` page (wrapped by its own `div` to render on a new line), but without providing `component_class` and `component_attributes`. That's because the `ProductInfo` page does not have the attributes of all products, but given that a user has to navigate to the `ProductInfo` page from the `ProductList` page, the attributes will be stored in history and linked to the home page URL (`/`), so when navigating back, it will happen instantly as well. If a user visits a bookmarked version of the `ProductInfo` page on the other hand, the `page_component_link` will automatically trigger a real page visit the first time, but afterwards, the `products_attributes` of the `ProductList` page are cached, so when navigating to a product and back, the navigation will happen instantly going forward. This is an example of Glimmer DSL for Web being very smart in addressing Software Engineering Frontend usability needs.

Solution:

`app/assets/opal/views/product_list_item.rb`:
```ruby
require 'views/product_info'

class ProductListItem
  include Glimmer::Web::Component

  attribute :product
      
  markup {
    li {
      page_component_link(component_class: ProductInfo, component_attributes: {product_attributes: product.to_h}, page_url: product.resource_path) {
        img(src: product.image_path, width: 200)
      }
      div {
        page_component_link(text: product.name, component_class: ProductInfo, component_attributes: {product_attributes: product.to_h}, page_url: product.resource_path)
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
      div {
        page_component_link(text: 'Back to products', page_url: '/')
      }
    }
  }
end
```

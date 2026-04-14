# Exercise 5 List Products (Style)

Feature: See a list of products with name, brand, gender, age, price, and image, in rows of 3 products per row, on the home page.

Topics: Glimmer HTML DSL, GLimmer CSS DSL, html_to_glimmer, css_to_glimmer, Glimmer Web Components

Usecase:

- Visit http://localhost:3000/
- See a list of products with name, brand, gender, age, price, and image in rows of 3 products per row

Steps:

1- Apply the style provided by a web designer in the following HTML & CSS

```html
<ul class="products">
  <li class="product-list-item">
    <img src="/images/t-shirts/t-shirt-navy-blue.svg" width=200>
    <div>
      T-Shirt 159 Navy Blue | Mirage | Female | Adult | $68.12
    </div>
  </li>
</ul>
```

```css
ul.products {
  padding: 0;
  list-style-type: none;
  display: flex;
  flex-wrap: wrap;
  align-items: stretch;
  max-width: 1185px;
}

li.product-list-item {
  flex: 0 0 33.33333%;
  min-width: 375px;
  max-width: calc(33.33% - 20px);
  margin: 20px 10px;
}
```

Tips:

- Copy the HTML content to a local `tmp/product_list.html` file and run the command `html_to_glimmer tmp/product_list.html` to generate `tmp/product_list.html.glimmer.rb`, which has a Glimmer Ruby HTML DSL version of the web designer HTML. The HTML change from the current code is adding `class: 'products'` to the `ul` element arguments in `ProductList`. There is NO need to add `class: 'product-list-item'` to the `li` element arguments in `ProductListItem` because Glimmer automatically give the markup root element in a component a CSS class matching a dashcased version of their name (i.e. `ProductListItem` gets the CSS class `product-list-item` added to the `li` markup root element)
- Copy the CSS content to a local `tmp/product_list.css` file and run the command `css_to_glimmer tmp/product_list.css` to generate `tmp/product_list.css.glimmer.rb`, which has a Glimmer Ruby CSS DSL version of the web designer CSS.
- Glimmer Web Components support a `style { }` block similar to `markup { }`, but for including CSS rules. Copy the first rule in `tmp/product_list.css.glimmer.rb` to a `style { }` block in `ProductList` and copy the second rule to a `style { }` block in `ProductListItem`.

Solution:

`app/assets/opal/views/product_list.rb`:

```ruby
require 'glimmer-dsl-web'

require 'presenters/product_list_presenter'
require 'views/product_list_item'

class ProductList
  include Glimmer::Web::Component

  attributes :products_attributes
  attr_reader :presenter
  
  before_render do
    @presenter = ProductListPresenter.new(products_attributes)
  end

  markup {
    div {
      h1 { 'Product List' }
      ul(class: 'products', style: {'list-style-type': 'none', 'padding': '0'}) {
        presenter.products.each do |product|
          product_list_item(product:)
        end
      }
    }
  }
  
  style {
    rule('ul.products') {
      padding '0'
      list_style_type 'none'
      display 'flex'
      flex_wrap 'wrap'
      align_items 'stretch'
      max_width '1185px'
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
```

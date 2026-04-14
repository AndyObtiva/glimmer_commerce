# Exercise 4 List Products (Refactor)

Feature (no change, only refactoring as per steps): See a list of products with name, brand, gender, age, price, and image on the home page.

Topics: MVP, Glimmer Web Components

Usecase (no change, only refactoring as per steps):

- Visit http://localhost:3000/
- See a list of products with name, brand, gender, age, price, and image

Steps:

1- Refactor/Extract a `Product` Model under `app/assets/opal/models/product.rb` with an initializer that takes keyword arguments for all product attributes coming in `products_attributes`. Make sure the app works without a change after this refactoring.
2- Refactor/Extract a `ProductListPresenter` Presenter under `app/assets/opal/presenters/product_list_presenter.rb` that accepts `products_attributes` via initializer and provides a `products` attribute that returns `Product` instances (converted from `products_attributes`). Make sure the app works without a change after this refactoring.
3- Refactor/Extract a `ProductListItem` Glimmer Web Component under `app/assets/opal/views/product_list_item.rb` that takes a `product` attribute as input and handles rendering the `li` element with all its contents (image + product `String`) for a product. Make sure the app works without a change after this refactoring.

Tips:

- `Product` can be implemented simply using Ruby `Struct` by passing all the necessary attribute symbols to the constructor + `keyword_init: true` to ensure `Product` has an initializer that can take keyword arguments (e.g. `User = Struct.new(:email, :password, keyword_init: true)`).
- Each product hash coming from the Backend has the following product attributes: `'id', 'name', 'description', 'price', 'brand', 'gender', 'age', 'image_path', 'created_at', 'updated_at', 'resource_path'`
- You can convert `products_attributes['products']` to `Product` instances inside a `@products` instance variable by adding a `before_render do end` block above `markup` in `ProductList` and then use `@products` inside markup to render `li` elements using product Model attributes
- In Opal, you can require Ruby files relative to `app/assets/opal` just like you do in any other Ruby app (e.g. `require 'models/user'` to use a file at `app/assets/opal/models/user`)
- You can declare attributes on a presenter using the basic Ruby `attr_accessor` (e.g. `attr_accessor :something`)
- You can update the `before_render` block in `ProductList` to instantiate a presenter in a `@presenter` instance variable, and move the conversion of `products_attributes['products']` to `Product` instances inside the presenter.
- Glimmer Web Components are classes that `include` the `Glimmer::Web::Component` module
- Including a `Glimmer::Web::Component` in a custom class automatically augments the Glimmer Ruby HTML DSL with a new keyword matches the underscored version of the class name by convention (e.g. a `UserProfile` component would support a `user_profile` keyword)
- Glimmer Web Components can declare input attributes with `attribute :someattr, default: 'somedefault'`, `attribute :someattr` (if no default is needed), or `attributes :someattr1, :someattr2, :someattr3` (if there is a need to declare multiple attributes on one line), and this will enable passing them as keyword arguments to the component keyword (e.g. `user_profile(user: administrator)` if `UserProfile` declares `attribute :user`)

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
      ul(style: {'list-style-type': 'none', 'padding': '0'}) {
        presenter.products.each do |product|
          product_list_item(product:)
        end
      }
    }
  }
end
```

`app/assets/opal/models/product.rb`:
```ruby
Product = Struct.new(:id, :name, :description, :price, :brand, :gender, :age, :image_path, :created_at, :updated_at, :resource_path, keyword_init: true)
```

`app/assets/opal/presenters/product_list_presenter.rb`:
```ruby
require 'models/product'

class ProductListPresenter
  attr_accessor :products
  
  def initialize(products_attributes)
    self.products = products_attributes['products'].map { |product_attributes| Product.new(**product_attributes) }
  end
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
        "#{product.name} | #{product.brand} | #{product.gender} | #{product.age} | #{product.price}`"
      }
    }
  }
end
```

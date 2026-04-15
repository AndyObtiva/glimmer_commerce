# Exercise 9 Filter Products By Name

Feature: Filter products by name

Topics: Glimmer HTML DSL, Observer, Bidirectional Data-Binding, Unidirectional Data-Binding, Content Data-Binding, Rails::ResourceService (REST API)

Usecase:

- Visit http://localhost:3000/
- See a list of products and a product name filter above the products
- Enter part of a product name in the filter (e.g. "Blue"), and the list gets filtered instantly by products matching the entered text. Additionally, you see a label saying `Displaying products filtered by name containing 'filtervalue'`
- The page indicates to you when no products are found

Steps:

1- Add a text `input` field (wrapped by its own `div`) above the products `ul` element and below the `h1` element, setting its `placeholder` attribute to `product name filter`
2- Do Bidirectional Data-Binding of the `input` field `value` to the `filter_product_name` attribute on the `@presenter` instance variable (the attribute will be added to the presenter class later below)
3- Add a `label` (wrapped by its own `div`) just below the `div` containing the text `input` field
4- Do Unidirectional Data-Binding of the `label` `inner_text` property to the `displaying_products_text` attribute on the `@presenter` instance variable while specifying that it is computed by `filter_product_name` (the attribute will be added to the presenter class later below)
5- Use Content Data-Binding inside the products `ul` element to bind its content to the attribute `products` on `ProductListPresenter` (`@presenter` instance variable). That will ensure that filtering the presenters `Array` will reflect changes in the View (Glimmer Web Component) automatically.
6- Add the `filter_product_name` as a Ruby attribute accessor on the `ProductListPresenter`
7- Implement the `displaying_products_text` method on the `ProductListPresenter`, computing its value from `filter_product_name`. When `filter_product_name` is not `nil`, the text returned says `Displaying products filtered by name containing "filtervalue"`; otherwise, it says `Displaying all products`.
8- Use a `Glimmer::DataBinding::Observer.proc {}` in `ProductListPresenter` (triggered when instantiating it) to observe changes in `filter_product_name` and use its value to fetch filtered products with a REST API call via `Rails::ResourceService` that passes `filter_product_name` as an HTTP request parameter when it is not empty.

Tips:

- Data-Binding is a technique that enables a Software Engineer to declaratively describe how they want the View data to be bound to Model/Presenter data, whether bidirectionally or unidirectionally, to ensure that a change in Model/Presenter data is reflected in the View and vice versa. This technique enables doing the work of pages of imperative code in one line of declarative code.
- Bidirectional Data-Binding synchronizes the property of a read-write View element (e.g. `input`) or component with the attribute of a Model or Presenter bidirectionally so that changes to either side propagate automatically to the other side. That is done by opening a multi-line block underneath the element (e.g. under `input {}`) and adding a data-binding expression starting with the View element/component property being data-bound (`value`) followed by `<=>` to indicate Bidirectional Data-Binding, followed by an array containing the name of the Model/Presenter object instance plus the attribute name as a Ruby `Symbol`. (e.g. `input { value <=> [user, :email] }` enables storing the typed in email inside the `User#email` attribute and if it changes in the Model for whatever reason, it is propagated back to the View)
- Unidirectional Data-Binding synchronizes the property of a read-only View element (e.g. `label`) or component with the attribute of a Model or Presenter unidirectionally so that changes to the Model/Presenter attribute propagate automatically to the View. That is done by opening a multi-line block underneath the element (e.g. under `input {}`) and adding a data-binding expression starting with the View element/component property being data-bound (`value`) followed by `<=` to indicate Unidirectional Data-Binding, followed by an array containing the name of the Model/Presenter object instance plus the attribute name as a Ruby `Symbol`. (e.g. `label { value <=> [user, :email] }` fills the label with the `User#email` attribute and if it changes in the Model for whatever reason, the changed version is propagated back to the View)
- Bidirectional/Unidirectional Data-Binding can be configured to be Computed Data-Binding by passing the `computed_by: attribute_symbol_or_attributes_array` option in the `Array` on the right side that contains the Model/Presenter instance and attribute name; this enables updating the view from a method that is computed based on some attribute or attributes (e.g. `label { value <=> [user, :full_name, computed_by: [:first_name, :last_name]] }`)
- Content Data-Binding re-renders the content of a View element whenever an attribute on a Model or Presenter changes by nesting a `content(object, attribute) { }` multi-line block underneath the element for which the content is being data-bound (often, the attribute is a collection, like `:products` for example). Then, inside the `content` block, you add elements that are dynamically rendered based on changes to the attribute in the `content` arguments (e.g. `ul { content(presenter, :products) { presenter.products.each { |product| ... } } }`)
- `Rails::ResourceService` enables making REST API calls to the Backend following Rails Route conventions, with support for passing in request parameters as needed. It has method for all the Rails CRUD operations of `index`, `show`, `destroy`, `create`, and `update`. The `index` method signature that matters to this exercise is `Rails::ResourceService.index(resource_class: Product, root: 'products', params: fetch_products_params)`.
- Make sure to add `require 'glimmer/data_binding/observer'` and `require 'rails/resource_service'` at the top of the `ProductListPresenter` file to use them.
- This exercise has a lot of new information, so it would probably be better to just copy code from the solution.

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
      div {
        input(type: :text, placeholder: 'product name filter') {
          value <=> [presenter, :filter_product_name]
        }
      }
      div(class: 'displaying-products-label-container') {
        label {
          inner_text <= [presenter, :displaying_products_text, computed_by: [:filter_product_name]]
        }
      }
      ul(class: 'products') {
        content(presenter, :products) {
          if presenter.products.any?
            presenter.products.each do |product|
              product_list_item(product:)
            end
          else
            li { "There are no products that match your search." }
          end
        }
      }
    }
  }
  
  style {
    r('ul.products') {
      padding '0'
      list_style_type 'none'
      display 'flex'
      flex_wrap 'wrap'
      align_items 'stretch'
      max_width '1215px'
    }
    
    r('.displaying-products-label-container') {
      margin_top 10
    }
  }
end
```

`app/assets/opal/presenters/product_list_presenter.rb`:
```ruby
require 'rails/resource_service'
require 'models/product'

class ProductListPresenter
  attr_accessor :products, :filter_product_name
  
  def initialize(products_attributes)
    self.products = products_attributes['products'].map { |product_attributes| Product.new(**product_attributes) }
    observe_filter
  end
  
  def displaying_products_text
    if filter_product_name.nil? || filter_product_name.empty?
      "Displaying all products"
    else
      "Displaying products filtered by name containing '#{filter_product_name}'"
    end
  end
  
  private
  
  def observe_filter
    @filter_observer = Glimmer::DataBinding::Observer.proc do
      fetch_products
    end
    @filter_observer.observe(self, :filter_product_name)
  end
  
  def fetch_products
    Rails::ResourceService.index(resource_class: Product,
                                 root: 'products',
                                 params: fetch_products_params) do |response, resources, metadata|
      self.products = resources
    end
  end
  
  def fetch_products_params
    params = {}
    params[:filter_product_name] = filter_product_name if filter_product_name
    params
  end
end
```

# Exercise 10 Sort Products

Feature: Sort products

Topics: Glimmer HTML DSL, Observer, Bidirectional Data-Binding, Rails::ResourceService (REST API)

Usecase:

- Visit http://localhost:3000/
- See a list of products plus a sort attribute dropdown (defauling to "featured", meaning sorting by ID) and a sort direction dropdown (defaulting to "Ascending")
- Change the sort attribute and/or the sort direction, and the product sorting changes

Steps:

1- In `ProductList`, add a `div` right above the `div` that contains the name filter, and inside the `div`, add 2 `select` elements, one for sort att
2- Populate the `sort_attribute` `select` element with options for the values `'id', 'name', 'brand', 'gender', 'age', 'price'`, with the displayed text being a capitalized version, except for `id`, which becomes `Featured`
3- Populate the `sort_direction` `select` element with options for the values `'asc', 'desc'`, with the displayed text being `Ascending` and `Descending`
4- Do Bidirectional Data-Binding of the first `select` element to `:sort_attribute` on `presenter`
5- Do Bidirectional Data-Binding of the second `select` element to `:sort_direction` on `presenter`
6- Update the `ProductListPresenter` to store `sort_attribute` and `sort_direction` from the `products_attributes` hash into `sort_attribute` and `sort_direction` as Ruby attributes (`attr_accessor`)
7- Rename `observe_filter` method to `observe_filter_and_sort`
8- Rename `@filter_observer` instance variable to `@filter_and_sort_observer` and have it observe `sort_attribute` and `sort_direction` in addition to `filter_product_name`
9- Update `fetch_products_params` to set `sort_attribute` and `sort_direction` as params

Tips:

- The same tips as those from the previous exercise apply here.

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
      div(class: 'sort-container') {
        label { 'Sort:' }
        select {
          value <=> [presenter, :sort_attribute]
          
          presenter.class::SORT_ATTRIBUTES.each do |sort_attribute|
            option(value: sort_attribute) { presenter.sort_attribute_text(sort_attribute) }
          end
        }
        select {
          value <=> [presenter, :sort_direction]
          
          presenter.class::SORT_DIRECTION_TO_TEXT.each do |sort_direction, sort_direction_display|
            option(value: sort_direction) { sort_direction_display }
          end
        }
      }
      div {
        input(type: :text, placeholder: 'product name filter') {
          value <=> [presenter, :filter_product_name]
        }
      }
      div(class: 'displaying-products-label-container') {
        label {
          inner_text <= [presenter, :displaying_products_text, computed_by: [:filter_product_name, :sort_attribute, :sort_direction]]
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
    
    r('.sort-container') {
      margin_bottom 10
    }
    
    r('.sort-container label') {
      margin_right 5
    }
    
    r('.sort-container select') {
      margin_right 5
    }
  }
end
```

`app/assets/opal/presenters/product_list_presenter.rb`:
```ruby
require 'rails/resource_service'
require 'models/product'

class ProductListPresenter
  SORT_ATTRIBUTES = ['id', 'name', 'brand', 'gender', 'age', 'price']
  SORT_ATTRIBUTE_TO_TEXT = {'id' => 'Featured'}
  SORT_DIRECTION_TO_TEXT = {'asc' => 'Ascending', 'desc' => 'Descending'}
  
  attr_accessor :products, :filter_product_name, :sort_attribute, :sort_direction
  
  def initialize(products_attributes)
    self.products = products_attributes['products'].map { |product_attributes| Product.new(**product_attributes) }
    self.sort_attribute = products_attributes[:sort_attribute]
    self.sort_direction = products_attributes[:sort_direction]
    observe_filter_and_sort
  end
  
  def displaying_products_text
    text = ''
    if filter_product_name.nil? || filter_product_name.empty?
      text += "Displaying all products"
    else
      text += "Displaying products filtered by name containing '#{filter_product_name}'"
    end
    text += " sorted by #{sort_attribute_text(sort_attribute).downcase}, #{SORT_DIRECTION_TO_TEXT[sort_direction].downcase}."
  end
  
  def sort_attribute_text(sort_attribute)
    if SORT_ATTRIBUTE_TO_TEXT.include?(sort_attribute)
      SORT_ATTRIBUTE_TO_TEXT[sort_attribute]
    else
      sort_attribute.capitalize
    end
  end
  
  private
  
  def observe_filter_and_sort
    @filter_and_sort_observer = Glimmer::DataBinding::Observer.proc do
      fetch_products
    end
    @filter_and_sort_observer.observe(self, :filter_product_name)
    @filter_and_sort_observer.observe(self, :sort_attribute)
    @filter_and_sort_observer.observe(self, :sort_direction)
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
    params[:sort_attribute] = sort_attribute if sort_attribute
    params[:sort_direction] = sort_direction if sort_direction
    params
  end
end
```

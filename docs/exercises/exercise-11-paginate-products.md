# Exercise 11 Paginate Products

Feature: Paginate products

Topics: Glimmer HTML DSL, Rails::ResourceService (REST API)

Usecase:

- Visit http://localhost:3000/
- See a paginated list of products with page links
- Click on a page link to see a different page of products

Steps:

1- Update `ProductListPresenter` to store `per_page`, `page`, `page_count` from the `products_attributes` hash in Ruby attributes (`attr_accessor`)
2- Add a `pages` Ruby attribute (`attr_accessor`) to `ProductListPresneter` that stores the numbers of available pages (e.g. if there are 5 pages of products, the `pages` attributes would return an array of `[1, 2, 3, 4, 5]`)
3- Implement a `ProductListPresneter` `compute_pages` method that computes the `Array` of page numbers based on the `page_count` attribute.
4- Update `Rails::ResourceService.index` REST API call in `ProductListPresneter` to store the new `per_page`, `page`, and `page_count` values it receives from the 3rd `metadata` argument
4- Have `compute_pages` get called in the `ProductListPresneter` initializer and on completion of every REST API call made with `Rails::ResourceService.index` inside the block it takes (after `page_count` is updated)
5- Update `@filter_and_sort_observer` to reset the `self` `page` attribute to `1` before calling `fetch_products` to ensure that filtering with less pages returned returns the user to page 1 to ensure having content
6- Implement a `go_to_page(page)` method on `ProductListPresenter` to use for page links that sets the `self` `page` attribute to a new value then calls `fetch_products`
7- Edit `ProductList` and add a `ul` at the bottom to contain all the pages returned from the presenter via a Content Data-Binding block that contains `li` elements for page links, which are implemented as an `a` tag inside the `li`, plus implement the `onclick` listener on every page link (inside the `a` tag) to have an empty `href` and `prevent_default` on the `onclick` event before actually calling `presenter.go_to_page(page)`
8- Apply the current CSS styles assuming they came from a web designer:

```css
ul.pages {
  padding: 0;
}
ul.pages li {
  display: inline;
  padding: '0 5px';
}
```

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
      ul(class: 'pages') {
        content(presenter, :pages) do
          presenter.pages.each do |page|
            li {
              a(page, href: "") {
                onclick do |event|
                  event.prevent_default
                  presenter.go_to_page(page)
                end
              }
            }
          end
        end
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
    
    r('ul.pages') {
      padding 0
    }
    
    r('ul.pages li') {
      display :inline
      padding '0 5px'
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
  
  attr_accessor :products, :filter_product_name, :sort_attribute, :sort_direction, :per_page, :page, :page_count, :pages
  
  def initialize(products_attributes)
    self.products = products_attributes['products'].map { |product_attributes| Product.new(**product_attributes) }
    self.per_page = products_attributes[:per_page]
    self.page = products_attributes[:page]
    self.page_count = products_attributes[:page_count]
    self.sort_attribute = products_attributes[:sort_attribute]
    self.sort_direction = products_attributes[:sort_direction]
    observe_filter_and_sort
    compute_pages
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
  
  def go_to_page(page)
    self.page = page
    fetch_products
  end
  
  private
  
  def observe_filter_and_sort
    @filter_and_sort_observer = Glimmer::DataBinding::Observer.proc do
      self.page = 1
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
      self.per_page = metadata[:per_page].to_i
      self.page = metadata[:page].to_i
      self.page_count = metadata[:page_count].to_i
      compute_pages
    end
  end
  
  def fetch_products_params
    params = {}
    params[:filter_product_name] = filter_product_name if filter_product_name
    params[:sort_attribute] = sort_attribute if sort_attribute
    params[:sort_direction] = sort_direction if sort_direction
    params[:page] = page if page != 1
    params[:per_page] = per_page if per_page != 15
    params
  end
  
  def compute_pages
    self.pages = (1..page_count).to_a.map(&:to_s)
  end
end
```

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

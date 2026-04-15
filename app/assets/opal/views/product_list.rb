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

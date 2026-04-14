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

require 'glimmer-dsl-web'

require 'models/product'
require 'presenters/product_collection_presenter'
require 'views/product_sorting'
require 'views/product_filtering'
require 'views/product_list_item'
require 'views/product_pagination'

class ProductList
  include Glimmer::Web::Component

  attributes :products_attributes
  attr_reader :presenter

  before_render do
    @presenter = ProductCollectionPresenter.new(products_attributes:)
  end

  markup {
    div {
      h1 { "Products" }
      product_sorting(presenter:)
      product_filtering(presenter:)
      product_pagination(presenter:)
      ul(class: 'products') {
        content(presenter, :products) do
          if presenter.products.any?
            presenter.products.each do |product|
              product_list_item(product:, presenter:)
            end
          else
            li { "There are no products that match your search." }
          end
        end
      }
      product_pagination(presenter:)
    }
  }
  
  style {
    r('.product-list ul.products') {
      padding 0
      list_style_type :none
      display :flex
      flex_wrap :wrap
      align_items :stretch
      max_width 1250
    }
  }
end

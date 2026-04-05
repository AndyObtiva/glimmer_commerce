require 'glimmer-dsl-web'

require 'models/product'
require 'presenters/product_collection_presenter'
require 'views/product_list_item'

class ProductList
  include Glimmer::Web::Component

  attributes :products_attributes, :per_page, :page, :page_count, :filter_product_name
  attr_reader :presenter

  before_render do
    @presenter = ProductCollectionPresenter.new(products_attributes:, per_page:, page:, page_count:, filter_product_name:)
  end

  markup {
    div {
      h1 { "Products" }
      input(type: :text, placeholder: 'product name filter') {
        value <=> [presenter, :filter_product_name]
      }
      ul {
        content(presenter, :products) do
          presenter.products.each do |product|
            product_list_item(product:, presenter:)
          end
        end
      }
      ul {
        content(presenter, :pages) do
          presenter.pages.each do |page|
            li {
              # TODO pull products via REST API upon pagination instead of navigating by A links
              # and perhaps cache results
              a(page, href: "/products?page=#{page}")
            }
          end
        end
      }
    }
  }
end

require 'glimmer-dsl-web'

require 'models/product'
require 'presenters/product_collection_presenter'
require 'views/product_list_item'

class ProductList
  include Glimmer::Web::Component

  attributes :products_attributes, :per_page, :page, :page_count
  attr_reader :presenter

  before_render do
    @presenter = ProductCollectionPresenter.new(products_attributes:, per_page:, page:, page_count:)
  end

  markup {
    div {
      h1 { "Products" }
      ul {
        content(presenter, :products) do
          presenter.products.each do |product|
            product_list_item(product:, presenter:)
          end
        end
      }
      ul {
        content(presenter, :product_pages) do
          presenter.pages.each do |page|
            li {
              a(page, href: "/products?page=#{page}")
            }
          end
        end
      }
    }
  }
end

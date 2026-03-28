require 'glimmer-dsl-web'

require 'models/product'
require 'presenters/product_presenter'
require 'views/product_list_item'

class ProductList
  include Glimmer::Web::Component

  attribute :products_json
  attr_reader :presenter

  before_render do
    @presenter = ProductPresenter.new(products_json:)
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
    }
  }
end

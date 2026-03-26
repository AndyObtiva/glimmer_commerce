require 'glimmer-dsl-web'

require 'models/product'
require 'presenters/product_presenter'

class ProductIndex
  include Glimmer::Web::Component

  attribute :products_json
  attr_reader :presenter

  before_render do
    @presenter = ProductPresenter.new(products_json: products_json)
    puts presenter.products
    puts presenter.products.first.name
  end

  markup {
    div {
      h1 { "Products" }
      ul {
        content(presenter, :products) do
          presenter.products.each do |product|
            li {
              "#{product.name} | $#{product.price}"
            }
          end
        end
      }
    }
  }
end

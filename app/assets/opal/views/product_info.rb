require 'glimmer-dsl-web'

require 'models/product'
require 'presenters/product_presenter'

class ProductInfo
  include Glimmer::Web::Component

  attribute :product_attributes
  attr_reader :presenter

  before_render do
    @presenter = ProductPresenter.new(product_attributes)
  end

  markup {
    div {
      h1 { presenter.product.name }
      p {
        presenter.product.brand
      }
      p {
        "$#{presenter.product.price}"
      }
      p {
        a(href: '/products') { 'Back' }
      }
    }
  }
end

require 'glimmer-dsl-web'

require 'models/product'
require 'models/order_line'
require 'models/order'
require 'presenters/editable_section_presenter'
require 'views/order_summary'
require 'views/order_address'

class OrderCheckout
  include Glimmer::Web::Component

  attribute :order_attributes
  attr_reader :order, :editable_section_presenter
  
  before_render do
    @order = Order.new(order_attributes)
    @editable_section_presenter = EditableSectionPresenter.new
  end

  markup {
    div {
      h1 { 'Checkout' }
      order_summary(order:)
      order_address(order:, address_attribute: :shipping_address, editable_section_presenter:)
#       order_address(order:, address_attribute: :billing_address, editable_section_presenter:)
#       payment_info(order:, editable_section_presenter:)
    }
  }
  
  style {
    r('.order-checkout') {
      width 1000
    }
  }
end

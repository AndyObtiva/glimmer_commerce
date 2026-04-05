require 'glimmer-dsl-web'

require 'models/order'
require 'views/payment_form'
require 'views/payment_display'
require 'views/editable_section'

class PaymentInfoEditableSection
  include Glimmer::Web::Component

  attributes :order
  attr_reader :payment_info
  
  before_render do
    @payment_info = order.payment_info
  end
  
  markup {
    editable_section(
      title: 'Payment Info',
      submit_button_text: 'Place Order',
      model: order.payment_info, # TODO this might not be needed
    ) {
      edit_form {
        payment_form(payment_info:)
      }
      saved_form_info {
        payment_display(payment_info:)
      }
      on_finish {
        # TODO do work
        $$.document.location.href = "/orders/#{order.id}"
      }
    }
  }
end

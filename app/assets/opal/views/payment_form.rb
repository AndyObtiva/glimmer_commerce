require 'glimmer-dsl-web'

require 'models/payment_info'

class PaymentForm
  include Glimmer::Web::Component

  attribute :payment_info
  
  # TODO do we want to process validation results in the Frontend or send back HTML from the Backend?
  # Or, do we want to support a new form Frontend component that can auto-process validation errors?
  markup {
    div {
      payment_info.payment_attributes.keys.each do |attribute|
        attribute_name = attribute.to_s.split('_').map(&:capitalize).join(' ')
        div(class: 'payment-attribute') {
          label { attribute_name }
          input(type: :text) { |input_element|
            value <=> [payment_info, attribute]
          }
        }
      end
    }
  }
  
  style {
    r('.payment-form .address-attribute') {
      margin_bottom 10
    }
    r('.payment-form label') {
      float :left
      width 200
    }
  }
end

require 'glimmer-dsl-web'

require 'models/payment_info'

class PaymentDisplay
  include Glimmer::Web::Component

  attribute :payment_info
  
  markup {
    div {
      class_name(:hidden) <= [payment_info, :blank?, computed_by: payment_info.payment_attributes.keys]
      
      payment_info.payment_attributes.each do |attribute, value|
        attribute_name = attribute.to_s.split('_').map(&:capitalize).join(' ')
        div(class: 'payment-attribute') {
          label(class: 'attribute-name') { "#{attribute_name}: " }
          label(class: 'attribute-value') {
            inner_html <= [payment_info, attribute, on_read: -> (value) { value || "&nbsp;" }]
          }
        }
      end
    }
  }
  
  style {
    r('.payment-display.hidden') {
      display :none
    }
    r('.payment-display .payment-attribute') {
      margin_bottom 10
    }
    r('.payment-display label') {
      display :block
    }
    r('.payment-display label.attribute-name') {
      float :left
      width 200
    }
  }
end

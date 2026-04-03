require 'glimmer-dsl-web'

require 'models/address'

class AddressForm
  include Glimmer::Web::Component

  attribute :address
  
  markup {
    div {
      address.to_h.except(:order).each do |attribute, value|
        attribute = attribute.to_s.split('_').map(&:capitalize).join(' ')
        div(class: 'address-attribute') {
          label { attribute }
          input(type: :text, value:)
        }
      end
    }
  }
  
  style {
    r('.address-form .address-attribute') {
      margin_bottom 10
    }
    r('.address-form label') {
      float :left
      width 200
    }
  }
end

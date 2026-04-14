require 'glimmer-dsl-web'

require 'models/address'

class AddressForm
  include Glimmer::Web::Component

  attribute :address
  
  markup {
    div {
      address.address_attributes.each do |attribute, _|
        attribute_name = attribute.to_s.split('_').map(&:capitalize).join(' ')
        div(class: 'address-attribute') {
          label { attribute_name }
          input(type: :text) { |input_element|
            value <=> [address, attribute]
          }
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

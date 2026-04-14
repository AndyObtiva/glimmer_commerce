require 'glimmer-dsl-web'

require 'models/address'

class AddressDisplay
  include Glimmer::Web::Component

  attribute :address
  
  markup {
    div {
      class_name(:hidden) <= [address, :blank?, computed_by: address.address_attributes.keys]
      
      address.address_attributes.each do |attribute, value|
        attribute_name = attribute.to_s.split('_').map(&:capitalize).join(' ')
        div(class: 'address-attribute') {
          label(class: 'attribute-name') { "#{attribute_name}: " }
          label(class: 'attribute-value') {
            inner_html <= [address, attribute, on_read: -> (value) { value || "&nbsp;" }]
          }
        }
      end
    }
  }
  
  style {
    r('.address-display.hidden') {
      display :none
    }
    r('.address-display .address-attribute') {
      margin_bottom 10
    }
    r('.address-display label') {
      display :block
    }
    r('.address-display label.attribute-name') {
      float :left
      width 200
    }
  }
end

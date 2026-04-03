require 'glimmer-dsl-web'

require 'models/order'
require 'views/address_form'
require 'views/address_display'
require 'views/editable_section'

class OrderAddress
  include Glimmer::Web::Component

  attributes :order, :address_name
  attr_reader :address_attribute, :title, :address
  events :on_submit
  
  before_render do
    @address_attribute = "#{address_name.downcase}_address"
    @address = order.send(address_attribute)
    @title = "#{address_name.capitalize} Address"
  end
  
  markup {
    editable_section(
      title: title,
      submit_button_text: 'Continue',
      model: address,
    ) {
      edit_form {
        address_form(address:)
      }
      saved_form_info {
        if !address.blank?
          address_display(address:)
        end
      }
      on_submit {
        # TODO do work
        notify_listeners(:on_submit) # TODO what do we pass as the object of the second argument?
      }
    }
  }
end

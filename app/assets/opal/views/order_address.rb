require 'glimmer-dsl-web'

require 'models/order'
require 'views/editable_section'

class OrderAddress
  include Glimmer::Web::Component

  attributes :order, :address_attribute, :editable_section_presenter
  events :on_submit
  
  markup {
    editable_section(
      title: 'Shipping Address',
      submit_button_text: 'Continue',
      model: order.send(address_attribute),
      presenter: editable_section_presenter,
    ) {
      edit_form {
        # TODO build form fields
        input(value: 'EDIT ME')
      }
      saved_form_info {
        # TODO build form fields
        label('SAVED')
      }
      on_submit {
        # TODO do work
        notify_listeners(:on_submit) # TODO what do we pass as the object of the second argument?
      }
    }
  }
end

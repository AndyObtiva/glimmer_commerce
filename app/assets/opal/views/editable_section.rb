require 'glimmer-dsl-web'

require 'presenters/editable_section_presenter'

class EditableSection
  include Glimmer::Web::Component

  events :on_submit
  attributes :title, :submit_button_text, :model, :presenter
  
  markup {
    div {
      # TODO add edit button
      # TODO add submit button
      # TODO add title
      # TODO add icon that shows number and whether things are saved
      a('Edit', href: '#') {
        onclick do
          presenter.editing = !presenter.editing
        end
      }
      div(slot: :edit_form, class: 'editable-section-edit-form') {
        class_name(:hidden) <= [presenter, :editing, on_read: :!]
        
      }
      div(slot: :saved_form_info, class: 'editable-section-saved-model-view') {
        class_name(:hidden) <= [presenter, :editing]
        
      }
    }
  }
  
  style {
    r('.editable-section .hidden') {
      display 'none'
    }
  }
end

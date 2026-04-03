require 'glimmer-dsl-web'

require 'presenters/editable_section_presenter'

class EditableSection
  include Glimmer::Web::Component

  events :on_submit
  attributes :title, :submit_button_text, :model
  attr_reader :presenter, :section
  
  before_render do
    @presenter = EditableSectionPresenter.instance
    @section = @presenter.add_section(title:)
  end
  
  markup {
    div {
      # TODO add edit button
      # TODO add submit button
      # TODO add title
      # TODO add icon that shows number and whether things are saved
      a('Edit', href: '#') {
        class_name(:hidden) <= [section, :editing]
        
        onclick do
          section.edit
        end
      }
      div(slot: :edit_form, class: 'editable-section-edit-form') {
        class_name(:hidden) <= [section, :editing, on_read: :!]
        
      }
      div(slot: :saved_form_info, class: 'editable-section-saved-model-view') {
        class_name(:hidden) <= [section, :editing]
      }
      button(submit_button_text, class: 'submit-button') {
        class_name(:hidden) <= [section, :editing, on_read: :!]
        
        onclick do
          submit_success = model.submit
          if submit_success
            presenter.edit_next_section
          end
        end
      }
    }
  }
  
  style {
    r('.editable-section') {
      width 500
      margin 15
      padding 15
      border '2px solid black' # TODO update with something nicer
      border_radius 15
    }
    r('.editable-section .hidden') {
      display :none
    }
    r('.editable-section .submit-button') {
      width 100.%
    }
  }
end

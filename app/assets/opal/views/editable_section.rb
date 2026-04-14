require 'glimmer-dsl-web'

require 'presenters/editable_section_presenter'

class EditableSection
  include Glimmer::Web::Component

  events :submit, :finish
  attributes :title, :submit_button_text, :model
  attr_reader :presenter, :section
  
  before_render do
    @presenter = EditableSectionPresenter.instance
    @section = @presenter.add_section(title:)
  end
  
  markup {
    div {
      a('Edit', href: '#') {
        class_name(:hidden) <= [section, :editing]
        
        onclick do
          section.edit
        end
      }
      h2 { title }
      div(slot: :edit_form, class: 'editable-section-edit-form') {
        class_name(:hidden) <= [section, :editing, on_read: :!]
        
      }
      div(slot: :saved_form_info, class: 'editable-section-saved-model-view') {
        class_name(:hidden) <= [section, :editing]
      }
      button(submit_button_text, class: 'submit-button') {
        class_name(:hidden) <= [section, :editing, on_read: :!]
        
        onclick do
          notify_listeners(:on_submit)
          model.submit do |success|
            if success
              result = presenter.edit_next_section
              if result == :finished
                notify_listeners(:finish)
              end
            end
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
      border '2px solid black'
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

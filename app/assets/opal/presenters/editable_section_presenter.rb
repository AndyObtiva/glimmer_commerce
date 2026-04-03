require 'singleton'

require 'glimmer/data_binding/observer'

require 'models/section'

# TODO move to EditableSection namespace
class EditableSectionPresenter
  include Singleton
  
  attr_reader :sections
  
  def initialize
    @sections = []
  end
  
  def add_section(title:)
    editing = true if sections.empty?
    section = Section.new(title:, editing:)
    sections << section
    observe_section_editing(section)
    section
  end
  
  def observe_section_editing(section)
    observer = Glimmer::DataBinding::Observer.proc do |editing|
      if editing
        other_sections = (sections - [section])
        other_sections.each(&:stop_editing)
      end
    end
    observer.observe(section, :editing)
  end
  
  # TODO support edit_next_empty_section
  def edit_next_section
    section_being_edited = sections.find(&:editing)
    section_being_edited_index = sections.index(section_being_edited)
    puts "section_being_edited_index < (sections.size - 1)"
    puts(section_being_edited_index < (sections.size - 1))
    if section_being_edited_index < (sections.size - 1)
      next_section_index = section_being_edited_index + 1
      sections[next_section_index].edit
    else
      section_being_edited.stop_editing
    end
  end
end

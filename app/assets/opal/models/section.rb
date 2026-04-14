Section = Struct.new(:title, :editing, keyword_init: true) do
  def edit
    self.editing = true
  end
  
  def stop_editing
    self.editing = false
  end
end

module PaginationHelper
  def per_page
    (params[:per_page] || 20).to_i
  end
  
  def page
    (params[:page] || 1).to_i
  end
  
  def page_offset
    (page - 1) * per_page
  end
  
  def page_count
    @page_count || 1
  end
  
  def sort_attribute
    # TODO validate sort attribute for security reasons
    params[:sort_attribute]
  end
  
  def sort_direction
    # TODO validate sort direction for security reasons
    params[:sort_direction] || 'asc'
  end
end

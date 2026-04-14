module PaginationHelper
  def per_page
    (params[:per_page] || 15).to_i
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
    raise 'Unsupported sort attribute!' if params[:sort_attribute].present? && !params[:sort_attribute].in?(Product.attribute_names)
    params[:sort_attribute] || 'id'
  end
  
  def sort_direction
    raise 'Unsupported sort direction!' if params[:sort_direction].present? && !params[:sort_direction].in?(['asc', 'desc'])
    params[:sort_direction] || 'asc'
  end
end

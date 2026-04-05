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
end

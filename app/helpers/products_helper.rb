module ProductsHelper
  def product_attributes
    ProductSerializer.new(@product).serializable_hash
  end
  
  def filter_product_name
    params[:filter_product_name]
  end
  
  def filter_product_brand
    params[:filter_product_brand] || []
  end
  
  def filter_product_gender
    params[:filter_product_gender] || []
  end
  
  def filter_product_age
    params[:filter_product_age] || []
  end
end

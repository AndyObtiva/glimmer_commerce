module ProductsHelper
  def product_attributes
    ProductSerializer.new(@product).serializable_hash
  end
  
  def products_attributes
    @products.map{ |product| ProductSerializer.new(product).serializable_hash }
  end
  
  def filter_product_name
    params[:filter_product_name]
  end
end

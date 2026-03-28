module ProductsHelper
  def product_attributes
    ProductSerializer.new(@product).serializable_hash
  end
  
  def products_attributes
    @products.map{ |product| ProductSerializer.new(product).serializable_hash }
  end
end

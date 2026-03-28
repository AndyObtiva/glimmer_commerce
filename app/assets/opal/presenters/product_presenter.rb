require 'models/product'

class ProductPresenter
  attr_accessor :product
  
  def initialize(product_attributes)
    @product = Product.new(**product_attributes)
  end
end

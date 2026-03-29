require 'models/product'

class ProductPresenter
  attr_accessor :product, :size, :quantity
  
  def initialize(product_attributes)
    @product = Product.new(**product_attributes)
    @size = 'M'
    @quantity = 1
  end
end

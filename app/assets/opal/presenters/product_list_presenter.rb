require 'models/product'

class ProductListPresenter
  attr_accessor :products
  
  def initialize(products_attributes)
    self.products = products_attributes['products'].map { |product_attributes| Product.new(**product_attributes) }
  end
end
